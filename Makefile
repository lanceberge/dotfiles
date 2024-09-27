# Detect the package manager and set the install command
is_ubuntu=false
is_mac=false
is_linux=false
ifeq ($(shell uname),Linux)
	install=apt install -y
	is_ubuntu=true
else ifeq ($(shell uname),Darwin)
	install=brew install
	is_mac=true
else ifeq ($(shell command -v pacman 2>/dev/null),pacman)
	install=sudo pacman -S --noconfirm
	is_linux=true
endif


clones:
	git clone git@github.com:lanceberge/.emacs.d.git ~/.emacs.d
	git clone git@github.com:lanceberge/org.git      ~/org
	git clone git@github.com:lanceberge/org-roam.git ~/org-roam
	git clone git@github.com:lanceberge/Notes.git    ~/org-roam/public
	git clone git@github.com:lanceberge/scripts.git  ~/code/scripts
	git clone git@github.com:lanceberge/secrets.git  ~/code/secrets


# TODO use GNU stow
symlinks:
	ln -sf ~/dotfiles/.zshrc              ~/.zshrc
	ln -sf ~/dotfiles/.gitconfig          ~/.gitconfig
	ln -sf ~/dotfiles/.bashrc             ~/.bashrc
	ln -sf ~/dotfiles/.bash_profile       ~/.bash_profile
	ln -sf ~/dotfiles/.zshenv             ~/.zshenv
	ln -sf ~/dotfiles/.config/nvim/.vimrc ~/.vimrc
	ln -sf ~/dotfiles/.config             ~/.config
	ln -sf ~/dotfiles/.osx                ~/.osx
	ln -sf ~/dotfiles/.tmux.conf          ~/.tmux.conf
	ln -sf ~/dotfiles/.ideavimrc          ~/.ideavimrc
	ln -sf ~/secrets/.authinfo            ~/.authinfo


system_packages:
	${install} tmux
	${install} zsh-completions
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" # oh my zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	curl -fLo ~/dotfiles/.config/nvim/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	@if [ "$is_linux" = true ]; then \
		curl -L https://nixos.org/nix/install | sh -s -- --daemon; \
		${install} zsh; \
		${install} vim; \
		${install} emacs; \
		echo $(which zsh) | sudo tee -a /etc/shells; \
		chsh -s $(which zsh); \

	elif [ "$is_mac" = true]; then \
		curl -L https://nixos.org/nix/install | sh; \
		curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"; \
		sudo installer -pkg AWSCLIV2.pkg -target /; \

		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
		brew tap d12frosted/emacs-plus; \
		${install} emacs-plus --with-native-comp; \
		brew tap homebrew/cask-fonts; \
		${install} font-dejavu; \
		ln -sf ~/dotfiles/settings.json ~/Library/Application\ Support/Code/User/settings.json; \
		${install} postgresql@16; \
		${install} --cask rectangle; \
	endif


python:
	${install} python3
	${install} python-pip
	pip install python-lsp-server


go:
	@if [ "$is_ubuntu" = true ]; then \
		rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz; \
	elif [ "$is_mac" = true]; then \
		${install} go; \
		go install golang.org/x/tools/gopls@latest; \
	fi

	go install mvdan.cc/sh/v3/cmd/shfmt@latest


rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


node:
	npm install -g typescript typescript-language-server prettier
	npm install -g svelte-language-server prettier-plugin-svelte


docker:
	mkdir -p ~/.oh-my-zsh/completions
	docker completion zsh > ~/.oh-my-zsh/completions/_docker


c:
	${install} cmake
	${install} lldb
	${install} llvm


clojure:
	${install} clojure/tools/clojure


bash:
	# Bash formatter
	npm install -g bash-language-server


lang: node go python rust c bash


all: clones symlinks system_packages lang
