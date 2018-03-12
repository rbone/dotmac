#!/bin/bash

export GOPATH=~/go

export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:$DOTMAC/.bin"

# Enable command history in zsh
#TODO: Read up more on history settings: http://zsh.sourceforge.net/Guide/zshguide02.html#l16
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# Necessary to enable the Ctrl+R command to reverse search command history
bindkey -e

# Configure prompt

function mac_add_prompt_collapse() {
  local match=$1
  local substitution=$2

  export PROMPT_COLLAPSE="$PROMPT_COLLAPSE:$match#$substitution"
}

mac_add_prompt_collapse "$MAC_HOME" "💖"

# Update the prompt whenever we change directory
function chpwd() {
  local current_dir="$(pwd)"

  echo "$PROMPT_COLLAPSE:$HOME#~" | tr ':' "\n" | while IFS='' read -r collapse; do
    match="$(echo "$collapse" | cut -d '#' -f 1)"
    substitution="$(echo "$collapse" | cut -d '#' -f 2)"

    current_dir="${current_dir/"$match"/"$substitution"}"
  done

  export PROMPT="%{$(tput setaf 2)%}[$current_dir]: %{$(tput sgr0)%}";
}

# Simple wrapper to allow calling helper commands in the form `mac <subcommand>`
function mac() {
  if [ -f $DOTMAC/.bin/mac-$1 ]; then
    source $DOTMAC/.bin/mac-$1 ${@:2}
  else
    source $DOTMAC/.bin/mac-help
  fi
}

# Helper to allow other scripts to easily load various other helper scripts
function mac_require() {
  local name="$1"

  if [ -f "$DOTMAC/lib/$name.sh" ]; then
    source "$DOTMAC/lib/$name.sh"
  else
    echo "Unknown require '$name'. Aborting."
    exit 1
  fi
}

# Run init scripts

cat "$DOTMAC/.init" | while IFS='' read -r script; do
  source $script
done

# Remove helpers not indended for use outside of init scripts

unset -f mac_add_prompt_collapse

# Start in $MAC_HOME instead of $HOME
cd "$MAC_HOME"
