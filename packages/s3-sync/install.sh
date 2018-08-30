#!/bin/bash

function s3-sync_install() {
  mac_require "brew"

  brew_package "$DOTMAC/packages/s3-sync"
}


s3-sync_install "$@"
