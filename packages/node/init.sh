#!/bin/bash

export NVM_DIR="$HOME/.nvm"

function load_nvm() {
  unset -f node
  unset -f npm

  source "/usr/local/opt/nvm/nvm.sh"
}

function nvm() {
  load_nvm

  nvm "$@"
}

function node() {
  load_nvm

  node "$@"
}

function npm() {
  load_nvm

  npm "$@"
}
