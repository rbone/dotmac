#!/bin/bash

function golang_install() {
  mac_require "brew"

  brew_package "$DOTMAC/packages/golang"

  # Hard to live without goimports
  go get golang.org/x/tools/cmd/goimports
}

golang_install $@
