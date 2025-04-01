# install packages
brew install bat
npm install -g git-aicommit

# stow dotfiles
stow git
stow zsh

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

cp .secrets.example ~/.secrets