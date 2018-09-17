#!/bin/bash

function ruby_install() {
  mac_require "brew"

  brew_package "$DOTMAC/packages/ruby"

  if [ -f "$DOTMAC/packages/ruby/.ruby-version" ]; then
    local version="$(cat "$DOTMAC/packages/ruby/.ruby-version")"

    chruby-exec "$desired_version" -- ruby --version > /dev/null 2>&1

    if [ $? -ne 0 ]; then
      ruby-install ruby "$version"
    fi
  fi
}

ruby_install $@
