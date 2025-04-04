# Source secrets file if it exists
[[ -f ${HOME}/.secrets ]] && source ${HOME}/.secrets

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-extras gh httpie iterm2 macos ssh zsh-autosuggestions zsh-syntax-highlighting you-should-use zsh-bat brew composer laravel symfony npm node command-not-found colored-man-pages )

source $ZSH/oh-my-zsh.sh

# ==================
# ALIASES AND FUNCTIONS
# ==================

alias list-npm-globals='npm list -g --depth=0'
# checkout branch using fzf
alias gcob='git branch | fzf | xargs git checkout'

alias python=python3

alias browser='open "https://$(basename $PWD).test"'

alias gai='git add . && git-aicommit'

# DIRCOLORS (MacOS)
export CLICOLOR=1

# FZF
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --margin=1 --padding=1"

# PATH
# export PATH=${PATH}:/usr/local/go/bin
# export PATH=${PATH}:${HOME}/go/bin

export BAT_THEME="gruvbox-dark"

func killwarp() {
  killall Cloudflare\ WARP
}

func startwarp() {
  open /Applications/Cloudflare\ WARP.app
}

# Function to detect and use the appropriate code editor
code_editor() {
  # PhpStorm is installed (based on the earlier check)
  if command -v phpstorm &> /dev/null; then
    phpstorm "$@"
  # Check for VS Code binary (not the alias)
  elif which code >/dev/null 2>&1 && [[ "$(which code)" != *"aliased to"* ]]; then
    "$(which code)" "$@"
  # Fallback to $EDITOR if set
  elif [[ -n "$EDITOR" ]]; then
    $EDITOR "$@"
  else
    echo "No code editor found. Install VS Code or PhpStorm, or set your EDITOR variable."
    return 1
  fi
}

# Unalias code if it exists
unalias code 2>/dev/null || true

# Create the alias to use our function
alias code="code_editor ."

alias ls='ls -a --color'
