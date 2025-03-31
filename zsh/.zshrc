# Export nvm completion settings for lukechilds/zsh-nvm plugin
# Note: This must be exported before the plugin is bundled
export NVM_DIR=${HOME}/.nvm
export NVM_COMPLETION=true

# Source secrets file if it exists
[[ -f ${HOME}/.my_dirty_little_secrets ]] && source ${HOME}/.my_dirty_little_secrets

# List out all globally installed npm packages
alias list-npm-globals='npm list -g --depth=0'
# checkout branch using fzf
alias gcob='git branch | fzf | xargs git checkout'
# cat -> bat
alias cat='bat'
# colored ls output
alias ls='ls -al --color'

# DIRCOLORS (MacOS)
export CLICOLOR=1

# FZF
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border --margin=1 --padding=1"

# PATH
# export PATH=${PATH}:/usr/local/go/bin
# export PATH=${PATH}:${HOME}/go/bin

export BAT_THEME="gruvbox-dark"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH

alias python=python3

alias browser='open "https://$(basename $PWD).test"'

alias artisan="${HOME}/Library/Application Support/Herd/bin/php artisan"

func killwarp() {
  killall Cloudflare\ WARP
}

func startwarp() {
  open /Applications/Cloudflare\ WARP.app
}

alias gai='git add . && git-aicommit && git push'

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

# Herd injected PHP binary.
export PATH="${HOME}/Library/Application Support/Herd/bin/":$PATH
