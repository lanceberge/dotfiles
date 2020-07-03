sudo pacman -S --noconfirm xorg
sudo pacman -S --noconfirm alacritty
sudo pacman -S --noconfirm zsh
sudo pacman -S --noconfirm ttf-dejavu
sudo pacman -S --noconfirm bspwm
sudo pacman -S --noconfirm sxhkd
sudo pacman -S --noconfirm nvim
sudo pacman -S --noconfirm git
sudo pacman -S --noconfirm neofetch
sudo pacman -S --noconfirm compton
sudo pacman -S --noconfirm tmux
sudo pacman -S --noconfirm fzf


mv ~/archdotfiles ~/dotfiles
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
chsh -s $(which zsh)
