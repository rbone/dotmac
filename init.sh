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

# Ruby config

source /usr/local/share/chruby/chruby.sh
chruby 2.4

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

function mac() {
  if [ -f $DOTMAC/.bin/mac-$1 ]; then
    $DOTMAC/.bin/mac-$1 ${@:2}
  else
    $DOTMAC/.bin/mac-help
  fi
}

# Run external init scripts

cat "$DOTMAC/.init" | while IFS='' read -r script; do
  source $script
done

# Remove helpers not indended for use outside of init scripts

unset -f mac_add_prompt_collapse

# Start in $MAC_HOME instead of $HOME
cd "$MAC_HOME"
