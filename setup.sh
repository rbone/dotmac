#!/bin/bash

function setup_brew() {
  if ! which "brew" > /dev/null 2>&1; then
    echo "Setup brew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function setup_zshrc() {
  if [ ! -e ~/.zshrc ]; then
    echo "Installing zshrc"

    local mac_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )"  && cd .. && pwd )"

    printf 'export MAC_HOME="%s"\nexport DOTMAC="%s/.mac"\nsource ~/Mac/.mac/init.sh' "$mac_home" "$mac_home" > ~/.zshrc

    touch ~/.hushlogin
  fi
}

function setup_dotmac() {
    local mac_home="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    touch "$mac_home/.init"
}

setup_dotmac
setup_brew
setup_zshrc
