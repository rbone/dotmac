#!/bin/bash

function git_install() {
  mac_require "brew"

  brew_package "$DOTMAC/packages/git"
}

function git_install_config() {
  if [ ! -f ~/.gitconfig ]; then
    cp "$DOTMAC/packages/git/conf/.gitconfig" ~/.gitconfig
  fi
  if [ ! -f ~/.gitignore ]; then
    cp "$DOTMAC/packages/git/conf/.gitignore" ~/.gitignore
  fi
}

function git_install_author() {
  if ! git config list --global | grep -q user.name; then
    echo "Git author name not set. Please provide one!"
    printf "Author Name: "
    read author_name
    git config --global user.name "$author_name"
  fi

  if ! git config list --global | grep -q user.email; then
    echo "Git author email not set. Please provide one!"
    printf "Author Email: "
    read author_email
    git config --global user.email "$author_email"
  fi
}

git_install
git_install_config
git_install_author
