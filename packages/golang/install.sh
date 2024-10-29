#!/bin/bash

function golang_install() {
  mac_require "brew"

  brew_package "$DOTMAC/packages/golang"

  # Hard to live without goimports
  mkdir -p "$MAC_HOME/go"
  GOPATH="$MAC_HOME/go" go install golang.org/x/tools/cmd/goimports@latest
}

golang_install $@
