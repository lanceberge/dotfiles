symlinks:
	ln -sf ~/dotfiles/.zshrc              ~/.zshrc
	ln -sf ~/dotfiles/.gitconfig          ~/.gitconfig
	ln -sf ~/dotfiles/.bashrc             ~/.bashrc
	ln -sf ~/dotfiles/.bash_profile       ~/.bash_profile
	ln -sf ~/dotfiles/.zshenv             ~/.zshenv
	ln -sf ~/dotfiles/.config/nvim/.vimrc ~/.vimrc

vim:
# curl -fLo ~/dotfiles/.config/nvim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# nvim +PlugInstall +qall

arch:
	pacman -S --noconfirm xwallpaper  # wallpapers
	pacman -S --noconfirm emacs       # OS
	pacman -S --noconfirm alacritty   # terminal emulator
	pacman -S --noconfirm zsh         # shell
	pacman -S --noconfirm bspwm       # window manager
	pacman -S --noconfirm sxhkd       # manage keyboard shortcuts
	pacman -S --noconfirm ttf-dejavu # font

archLarge:
	pacman -S --noconfirm texlive-core # latex
	pacman -S --noconfirm texlive-latexextra

clones:
	git clone git@github.com:lanceberge/.kde4.git ~/.kde4
	git clone git@github.com:lanceberge/.emacs.d.git ~/.emacs.d

all:
	make symlinks
	make arch
	make archLarge
	make clones
