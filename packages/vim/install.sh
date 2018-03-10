#!/bin/bash

set -eu
shopt -s nullglob

VIM_DIR="$DOTMAC/packages/vim"

MAC_CHECKMARK="\\033[32m✔\\033[0m"
#MAC_CROSS="\\e[31m✗\\e[0m"

function install_dependencies() {
  update_all_repos

  grep "git@github" "$VIM_DIR/deps" | while read -r line; do
    repo=$(echo "$line" | cut -d ' ' -f 1)
    name=$(echo "$line" | cut -d ' ' -f 2)
    version=$(echo "$line" | cut -d ' ' -f 3)

    if [ ! -d "$VIM_DIR/bundle/$name" ]; then
      printf " - %s installing " "$(make_green "$name")"
      git clone "$repo" "$VIM_DIR/bundle/$name" > /dev/null 2>&1
      checkout_version "$name" "$version"
      printf "%b\\n" "$MAC_CHECKMARK"
    elif dependency_up_to_date "$name" "$version"; then
      printf " - %s up to date %b\\n" "$(make_green "$name")" "$MAC_CHECKMARK"
    else
      printf " - %s updating from %s to %s " "$(make_green "$name")" "$(current_version "$name")" "$(desired_version "$name" "$version")"
      checkout_version "$name" "$version"
      printf "%b\\n" "$MAC_CHECKMARK"
    fi
  done

  create_lockfile

  echo ""
}

function install_symlinks() {
  printf "Symlinking .vimrc to ~/.vimrc"
  ln -sf "$VIM_DIR/.vimrc" ~/.vimrc
  printf " %b\\n\\n" "$MAC_CHECKMARK"
}

function install_swap() {
  printf "Creating swap directory"
  mkdir -p "$VIM_DIR/swap"
  printf " %b\\n\\n" "$MAC_CHECKMARK"
}

function make_green() {
  printf "%b" "\\033[32m$1\\033[0m"
}

function update_all_repos() {
  printf "Fetching latest versions of all installed dependencies"

  for repo in $VIM_DIR/bundle/*; do
    printf "."

    git \
      --git-dir="$repo/.git" \
      --work-tree="$repo" \
      fetch \
      > /dev/null 2>&1

  done
  printf " %b\\n\\n" "$MAC_CHECKMARK"
}

function checkout_version() {
  local name=$1
  local version=$2

  git \
    --git-dir="$VIM_DIR/bundle/$name/.git" \
    --work-tree="$VIM_DIR/bundle/$name" \
    checkout "$version" \
    > /dev/null 2>&1
}

# Creates a lockfile, though it's not really a lockfile yet
# as it doesn't ensure only those versions in the lockfile
# are installed. One day it might, but for now it at least
# helps track what versions are being used so that if they
# do change it will be visible.
function create_lockfile() {
  local lock=""
  for repo in $VIM_DIR/bundle/*; do
    name="$(basename "$repo")"
    lock="$lock$name $(current_version "$name")\\n"
  done
  printf "%b" "$lock" > deps.lock
}

function current_version() {
  local name=$1

  (git \
    --git-dir="$VIM_DIR/bundle/$name/.git" \
    --work-tree="$VIM_DIR/bundle/$name" \
    rev-parse HEAD
  )
}

function desired_version()  {
  local name=$1
  local version=$2

  (git \
    --git-dir="$VIM_DIR/bundle/$name/.git" \
    --work-tree="$VIM_DIR/bundle/$name" \
    rev-parse "$version"
  )
}

function dependency_up_to_date() {
  local name=$1
  local version=$2

  if [ "$(current_version "$name")" = "$(desired_version "$name" "$version")" ]; then
    return 0
  else
    return 1
  fi
}

install_dependencies
install_symlinks
install_swap
echo "Finished"