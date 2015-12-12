if type locale >/dev/null 2>&1; then
  if locale -a | ja_JP.utf8 > /dev/null; then
    export LANG=ja_JP.UTF-8
  fi
fi

if [[ -d "$HOME/.env.d" ]] ; then
  for i in $HOME/.env.d/*.sh; do
    . $i
  done
fi
