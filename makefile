symlinks:
	ln -sf ~/dotfiles/.zshrc ~/.zshrc
	ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
	ln -sf ~/dotfiles/.bashrc ~/.bashrc
	ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
	ln -sf ~/dotfiles/.zshenv ~/.zshenv
	ln -sf ~/dotfiles/.config/nvim/.vimrc ~/.vimrc

vim:
# curl -fLo ~/dotfiles/.config/nvim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# nvim +PlugInstall +qall

arch:
	pacman -S --noconfirm xwallpaper
	pacman -S --noconfirm zsh
	pacman -S --noconfirm emacs
	pacman -S --noconfirm bspwm
	pacman -S --noconfirm alacritty
	pacman -S --noconfirm zsh
	pacman -S --noconfirm bspwm
	pacman -S --noconfirm sxhkd

archLarge:
	pacman -S --noconfirm texlive-core
	pacman -S --noconfirm texlive-latexextra

clones:
	git clone git@github.com:lanceberge/.kde4.git ~/.kde4
	git clone git@github.com:lanceberge/.emacs.d.git ~/.emacs.d

all:
	make symlinks
	make arch
	make clones
