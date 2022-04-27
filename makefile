install=pacman -S
flags=""


symlinks:
	ln -sf ~/dotfiles/.zshrc              ~/.zshrc
	ln -sf ~/dotfiles/.gitconfig          ~/.gitconfig
	ln -sf ~/dotfiles/.bashrc             ~/.bashrc
	ln -sf ~/dotfiles/.bash_profile       ~/.bash_profile
	ln -sf ~/dotfiles/.zshenv             ~/.zshenv
	ln -sf ~/dotfiles/.config/nvim/.vimrc ~/.vimrc


## arch specific
arch_packages:
	pacman -S --noconfirm xwallpaper  # wallpapers
	pacman -S --noconfirm emacs       # OS
	pacman -S --noconfirm zsh         # shell
	pacman -S --noconfirm bspwm       # window manager
	pacman -S --noconfirm sxhkd       # manage keyboard shortcuts
	pacman -S --noconfirm ttf-dejavu  # font
	pacman -S --noconfirm ispell
	pacman -S --noconfirm alacritty   # terminal emulator


arch:
	make arch_packages
	rm -rf ~/.kde4
	rm -rf ~/.config
	git clone git@github.com:lanceberge/.kde4.git   ~/.kde4
	git clone git@github.com:lanceberge/.config.git ~/.config


mac:
	# install brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install --cask emacs
	

python_packages:
	${install} ${flags} python3
	${install} ${flags} python-pip
	pip install numpy matplotlib pandas


all_packages:
	make python_packages
	${install} ${flags} texlive-core # latex
	${install} ${flags} texlive-latexextra


clones:
	git clone git@github.com:lanceberge/.emacs.d.git ~/.emacs.d
	git clone git@github.com:lanceberge/org.git      ~/org
	git clone git@github.com:lanceberge/school.git   ~/school


all:
	make symlinks
	make all_packages
	make clones
