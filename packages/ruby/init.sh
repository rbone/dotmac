#!/bin/bash

source /usr/local/share/chruby/chruby.sh

function ruby_init() {
  if [ -f "$DOTMAC/packages/ruby/.ruby-version" ]; then
    local version="$(cat "$DOTMAC/packages/ruby/.ruby-version")"

    chruby "$version"
  fi
}

ruby_init

unset -f ruby_init
