# PS1
export PS1="\[$(tput bold)\]\[\033[38;5;5m\]\w \[$(tput sgr0)\]"

# --- Aliases ---
alias ll="ls -Alh --color"
alias ds="du -hs"
alias d="cd ~/Desktop"
alias gc1="git clone --depth 1"
alias ms='multipass shell'

# --- quickly reload bash profile or bashrc ---
if test -e ~/.bash_profile
then
    alias rrr=". ~/.bash_profile"
elif test -e ~/.bashrc
then
    alias rrr=". ~/.bashrc"
fi

# --- Functions ---
helpme() {
    echo "emojied [URL]"
    echo "af8x [URL]"
    echo "upload-ipfs [file]"
    echo "rrr Reload bash profile"
}

emojied() {
    curl -X POST -d "{\"url\":\"$1\",\"identifier\":\"\"}" \
        -H 'content-type: application/json' \
        -fsSL "https://emojied.net/rpc/shorten-url" | cut -f 4 -d '"'
}

af8x() {
    curl -X POST -d "{\"url\":\"$1\"}" \
        -H 'referer: https://a.f8x.io' \
        -fsSL "https://a.f8x.io" | grep -E -i -o '\/[a-z0-9]+' | \
        printf https://a.f8x.io%s $(</dev/stdin)
}

upload-ipfs() {
    curl "https://ipfs.infura.io:5001/api/v0/add?pin=true&cid-version=1" -X POST \
        -H 'Content-Type: multipart/form-data' -F file=@"$1" \
        -fsSL | awk -F '"' '{print $8}'
}
