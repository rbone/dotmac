#!/bin/bash

export NVM_DIR="$HOME/.nvm"
function nvm() {
  source "/usr/local/opt/nvm/nvm.sh"
  nvm "$@"
}
