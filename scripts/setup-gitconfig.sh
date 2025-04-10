#!/usr/bin/env bash

# Get Git config from args
GIT_NAME="${1:-$GIT_NAME}"
GIT_EMAIL="${2:-$GIT_EMAIL}"

# Final validation
if [[ -z "$GIT_NAME" || -z "$GIT_EMAIL" ]]; then
  echo "❌ GIT_NAME or GIT_EMAIL not set. Please provide as arguments or define in ~/.secrets"
  exit 1
fi

# Write ~/.gitconfig.local
cat <<EOF > ~/.dotfiles/git/.gitconfig.local
[user]
    name = $GIT_NAME
    email = $GIT_EMAIL
EOF

echo "✅ ~/.gitconfig.local created with your Git identity."
