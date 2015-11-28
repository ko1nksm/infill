#!/usr/bin/env bash

set -eu

# ---------- Edit below here ----------
INSTALL_DIR="$HOME/.reno"
AUTO_INSTALL=
AUTO_YES=

# install via git
REPOSITORY="https://github.com/ko1nksm/reno.git"
INFILL_REPOSITORY="git@github.com:ko1nksm/infill.git"

# install from archive
INSTALLER="https://raw.githubusercontent.com/ko1nksm/reno/master/install.sh"
INFILL_ARCHIVE="https://github.com/ko1nksm/infill/archive/master.zip"
INFILL_ARCHIVE_FORMAT="auto"
# ---------- Edit above here ----------


export RENO_YES=${AUTO_YES:-}

if type git > /dev/null 2>&1; then
  if [[ -e $INSTALL_DIR || -L $INSTALL_DIR ]]; then
    echo "Found reno directory. skipping reno installation."
  else
    git clone "$REPOSITORY" "$INSTALL_DIR"
    "$INSTALL_DIR/install.sh"
  fi

  if [[ $INFILL_REPOSITORY && $INFILL_REPOSITORY != "YOUR-INFILL-REPOSITORY" ]]; then
    "$INSTALL_DIR/bin/reno" init "$INFILL_REPOSITORY"
  fi
else
  if [[ ! $INSTALLER ]]; then
    echo "Git not found."
    exit 1
  fi

  if [[ $AUTO_YES ]]; then
    echo "Git not found. Import from archive."
  else
    echo -n "Git not found. Do you want to import from an archive? [y/N] "
    read input
  fi
  [[ $input = "y" || $input = "Y" ]] || exit 1

  if type curl > /dev/null 2>&1; then
    bash -c "$(curl -L $INSTALLER)"
  elif type wget > /dev/null 2>&1; then
    bash -c "$(wget -O - $INSTALLER)"
  else
    echo "Not found git, wget, curl. Aborting"
    exit 1
  fi

  if [[ $INFILL_ARCHIVE && $INFILL_ARCHIVE != "YOUR-INFILL-ARCHIVE" ]]; then
    "$INSTALL_DIR/bin/reno" init "$INFILL_ARCHIVE" --type archive --format "$INFILL_ARCHIVE_FORMAT"
  fi
fi

if [[ $AUTO_INSTALL ]]; then
  "$INSTALL_DIR/bin/reno" install
fi
