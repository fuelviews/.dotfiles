#!/usr/bin/env bash

# Get Git config from args or environment
GIT_NAME="${1:-$GIT_NAME}"
GIT_EMAIL="${2:-$GIT_EMAIL}"

# If still not set, try loading from secrets file
if [[ -z "$GIT_NAME" || -z "$GIT_EMAIL" ]]; then
  [[ -f "${HOME}/.secrets" ]] && source "${HOME}/.secrets"
fi

# Final validation
if [[ -z "$GIT_NAME" || -z "$GIT_EMAIL" ]]; then
  echo "❌ GIT_NAME or GIT_EMAIL not set. Please provide as arguments or define in ~/.secrets"
  exit 1
fi

# Write ~/.gitconfig.local
cat <<EOF > ~/.gitconfig.local
[user]
    name = $GIT_NAME
    email = $GIT_EMAIL
EOF

echo "✅ ~/.gitconfig.local created with your Git identity."
