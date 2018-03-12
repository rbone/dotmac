#!/bin/bash

export PATH="$PATH:$DOTMAC/packages/git/.bin"

if [ -f "$DOTMAC/packages/git/.author_email" ]; then
  export GIT_AUTHOR_EMAIL="$(cat "$DOTMAC/packages/git/.author_email")"
  export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
fi

if [ -f "$DOTMAC/packages/git/.author_name" ]; then
  export GIT_AUTHOR_NAME="$(cat "$DOTMAC/packages/git/.author_name")"
  export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
fi
