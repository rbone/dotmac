#!/bin/bash

function install_yubikey() {
  mac_require "brew"

  brew_package "$DOTMAC/packages/yubikey"
}

install_yubikey &&
echo "Finished"

