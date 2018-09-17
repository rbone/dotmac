#!/bin/bash

export NVM_DIR="$HOME/.nvm"
function nvm() {
  source "/usr/local/opt/nvm/nvm.sh"
  nvm "$@"

  unset -f node
}

function node() {
  nvm > /dev/null 2>&1

  node "$@"
}
