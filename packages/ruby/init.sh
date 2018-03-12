#!/bin/bash

source /usr/local/share/chruby/chruby.sh

if [ -f "$DOTMAC/packages/ruby/.ruby-version" ]; then
  local version="$(cat "$DOTMAC/packages/ruby/.ruby-version")"

  chruby "$version"
fi
