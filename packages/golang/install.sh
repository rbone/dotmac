#!/bin/bash

function golang_install() {
  mac_require "brew"

  brew_package "$DOTMAC/packages/golang"
}

golang_install $@
