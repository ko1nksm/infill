if type dircolors >/dev/null; then
  if [ -f ~/.dir_colors ]; then
    eval $(dircolors -b ~/.dir_colors)
    zstyle ':completion:*' list-colors "${LS_COLORS}"
  fi
fi
