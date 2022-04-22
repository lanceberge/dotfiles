install=pacman -S
flags=""

symlinks:
	ln -sf ~/dotfiles/.zshrc              ~/.zshrc
	ln -sf ~/dotfiles/.gitconfig          ~/.gitconfig
	ln -sf ~/dotfiles/.bashrc             ~/.bashrc
	ln -sf ~/dotfiles/.bash_profile       ~/.bash_profile
	ln -sf ~/dotfiles/.zshenv             ~/.zshenv
	ln -sf ~/dotfiles/.config/nvim/.vimrc ~/.vimrc
	ln -sf  /usr/bin/python3               /usr/bin/python


arch_packages:
	${install} ${flags} alacritty   # terminal emulator


base_packages:
	${install} ${flags} xwallpaper  # wallpapers
	${install} ${flags} emacs       # OS
	${install} ${flags} zsh         # shell
	${install} ${flags} bspwm       # window manager
	${install} ${flags} sxhkd       # manage keyboard shortcuts
	${install} ${flags} ttf-dejavu  # font
	${install} ${flags} ispell


python_packages:
	${install} ${flags} python3
	${install} ${flags} python-pip


all_packages:
	make base_packages
	make python_packages
	${install} ${flags} texlive-core # latex
	${install} ${flags} texlive-latexextra


# clone repos
clones:
	# rm -rf ~/.kde4
	# rm -rf ~/.config
	# git clone git@github.com:lanceberge/.kde4.git ~/.kde4
	git clone git@github.com:lanceberge/.emacs.d.git ~/.emacs.d
	git clone git@github.com:lanceberge/org.git ~/org
	# git clone git@github.com:lanceberge/.config.git ~/.config
	git clone git@github.com:lanceberge/school.git ~/school


all:
	make symlinks
	make all_packages
	make clones


nvim:
    curl -fLo ~/dotfiles/.config/nvim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    nvim +PlugInstall +qall
