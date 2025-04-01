# Check if Oh My Zsh is already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  
  # Create backup with timestamp
  timestamp=$(date +%Y%m%d_%H%M%S)
  mv ~/.zshrc ~/.zshrc_bak_${timestamp}
else
  echo "Oh My Zsh is already installed, skipping..."
fi

# stow dotfiles
stow git
stow zsh

# install brew packages
packages=(
  stow
  zsh-autosuggestions
  zsh-syntax-highlighting
  bat
  yarn
  nvm
  oven-sh/bun/bun
  jpegoptim
  optipng
  pngquant
  gifsicle
  webp
  libavif
)
for package in "${packages[@]}"; do
  if ! brew list "$package" &>/dev/null; then
    echo "Installing $package..."
    brew install "$package"
  else
    echo "$package already installed, skipping..."
  fi
done

packages=(
  git-aicommit
  svgo
)
for package in "${packages[@]}"; do
  if ! npm -g list "$package" &>/dev/null; then
    echo "Installing $package..."
    npm install -g "$package"
  else
    echo "$package already installed, skipping..."
  fi
done

# Make sure ZSH_CUSTOM is set correctly
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

declare -A repos
repos[0]="https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
repos[1]="https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
repos[2]="https://github.com/fdellwing/zsh-bat.git ${ZSH_CUSTOM}/plugins/zsh-bat"
repos[3]="https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM}/plugins/you-should-use"

for repo in "${repos[@]}"; do
  url=$(echo "$repo" | awk '{print $1}')
  dir=$(echo "$repo" | awk '{print $2}')
  if [ ! -d "$dir" ]; then
    echo "Cloning $url to $dir..."
    git clone "$url" "$dir"
  else
    echo "Repository already exists at $dir, skipping..."
  fi
done

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# Only copy secrets file if it doesn't exist
if [ ! -f ~/.secrets ]; then
  cp .secrets.example ~/.secrets
  echo "Created ~/.secrets from template"
else
  echo "~/.secrets already exists, skipping..."
fi