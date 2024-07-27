# Detect the package manager and set the install command
ifeq ($(shell uname),Ubuntu)
	install=sudo apt install -y
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
	git clone git@github.com:lanceberge/scripts.git  ~/code/scripts


symlinks: clones
	ln -sf ~/dotfiles/.zshrc              ~/.zshrc
	ln -sf ~/dotfiles/.gitconfig          ~/.gitconfig
	ln -sf ~/dotfiles/.bashrc             ~/.bashrc
	ln -sf ~/dotfiles/.bash_profile       ~/.bash_profile
	ln -sf ~/dotfiles/.zshenv             ~/.zshenv
	ln -sf ~/dotfiles/.config/nvim/.vimrc ~/.vimrc
	ln -sf ~/dotfiles/.osx                ~/.osx
	ln -sf ~/dotfiles/.tmux.conf          ~/.tmux.conf


system_packages:
	${install} emacs
	${install} vim

	ifeq($(is_linux), true)
	    ${install} xwallpaper  # wallpapers
	    ${install} zsh         # shell
	    ${install} bspwm       # window manager
	    ${install} sxhkd       # manage keyboard shortcuts
	    ${install} ttf-dejavu  # font
	    ${install} ispell
	    ${install} alacritty   # terminal emulator

	else ifeq($(is_mac), true)
	    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	    ${install} --cask emacs
	    brew tap homebrew/cask-fonts
	    ${install} font-dejavu
	    ln -sf ~/dotfiles/settings.json ~/Library/Application\ Support/Code/User/settings.json
	    ${install} postgresql@16
	    ${install} --cask rectangle
	    ${install} cmake


python:
	${install} python3
	${install} python-pip
	pip install python-lsp-server


go:
	ifeq($(is_ubuntu), true)
	    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz

	else ifeq($(is_mac), true)
	    ${install} go

	go install golang.org/x/tools/gopls@latest


node:
	npm install -g typescript typescript-language-server prettier
