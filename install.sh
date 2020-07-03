# Necessary packages
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

# Symlinks
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

chsh -s $(which zsh) # Use zsh

# Set up vim plug
curl -fLo ~/dotfiles/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim