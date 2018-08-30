#!/bin/bash

function s3-sync() {
  if [ -f "$DOTMAC/packages/s3-sync/.bin/s3-sync-$1" ]; then
    source "$DOTMAC/packages/s3-sync/.bin/s3-sync-$1" "${@:2}"
  else
    source "$DOTMAC/.bin/s3-sync-help"
  fi
}

