## Symlinks
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/dotfiles/.zshenv ~/.zshenv

# Vim
ln -sf ~/dotfiles/.config/nvim ~/.vim
ln -sf ~/dotfiles/.config/nvim/init.vim ~/.vimrc

## Set up vim plug
curl -fLo ~/dotfiles/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qall
