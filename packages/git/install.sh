#!/bin/bash

function git_install() {
  mac_require "brew"

  brew_package "$DOTMAC/packages/git"
}

function git_install_config() {
  cp "$DOTMAC/packages/git/conf/.gitconfig" ~/.gitconfig
  cp "$DOTMAC/packages/git/conf/.gitignore" ~/.gitignore
}

function git_install_author() {
  if [ ! -f "$DOTMAC/packages/git/.author_name" ]; then
    echo "Git author name not set. Please provide one!"
    printf "Author Name: "
    read author_name
    echo "$author_name" > "$DOTMAC/packages/git/.author_name"
  fi

  if [ ! -f "$DOTMAC/packages/git/.author_email" ]; then
    echo "Git author email not set. Please provide one!"
    printf "Author Email: "
    read author_email
    echo "$author_email" > "$DOTMAC/packages/git/.author_email"
  fi
}

git_install
git_install_config
git_install_author
