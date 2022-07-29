ARCH=`uname -s`

all: bash vim

bush:
	@curl -fsSL -o ~/.bush https://raw.fastgit.org/gygkdb/dotfiles/main/bu.sh
	@if test $(ARCH) == "Darwin"; \
	then \
		echo '\n. $$HOME/.bush\n' >> ~/.bash_profile; \
	else \
		echo '\n. $$HOME/.bush\n' >> ~/.bashrc; \
	fi

vim:
	@curl -fsSL -o ~/.vimrc https://raw.fastgit.org/gygkdb/dotfiles/main/vimrc
