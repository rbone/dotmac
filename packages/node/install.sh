
function node_install() {
  mac_require "brew"

  brew_package "$DOTMAC/packages/node"
}

node_install $@
