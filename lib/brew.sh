#!/bin/bash


function brew_package() {
  local package_directory="$1"

  brew_assert_installed

  if [ ! -f "$package_directory/Brewfile" ]; then
    echo "Couldn't find Brewfile in '$package_directory'. Aborting."
    exit 1
  fi

  brew bundle --file="$package_directory/Brewfile"
}

function brew_assert_installed() {
  which brew > /dev/null 2>&1

  if [ $? -ne 0 ]; then
    echo "Brew is not installed! Aborting."
    exit 1
  fi
}
