#!/usr/bin/env bash

RENO_REPO="https://github.com/ko1nksm/reno.git"
INSTALLER="https://raw.githubusercontent.com/ko1nksm/reno/master/install.sh"
INFILL_REPO="git@github.com:ko1nksm/infill.git"
INFILL_ARCHIVE="https://github.com/ko1nksm/infill/archive/master.tar.gz"

RENO_DIR="$HOME/.reno"
INFILL_DIR="$HOME/.infill"

if type git > /dev/null 2>&1; then
  if [[ -e $RENO_DIR ]]; then
    echo "Found reno directory. skipping reno installation."
  else
    git clone $RENO_REPO $RENO_DIR
    $RENO_DIR/install.sh
  fi
  $RENO_DIR/bin/reno init $INFILL_REPO
else
  echo -n "Git not found. Do you want to import from an archive? [y/N] "
  read input
  [[ $input = "y" || $input = "Y" ]] || exit 1
  if type curl > /dev/null 2>&1; then
    bash -c "$(curl -L $INSTALLER)"
  elif type wget > /dev/null 2>&1; then
    bash -c "$(wget -O - $INSTALLER)"
  else
    echo "Not found git, wget, curl. Aborting"
    exit 1
  fi
  $RENO_DIR/bin/reno init $INFILL_ARCHIVE --type archive
fi
