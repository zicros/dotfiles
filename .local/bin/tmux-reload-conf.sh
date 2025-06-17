#!/usr/bin/bash

CONFIG_DIR="$HOME/.config/tmux/config.d"

for file in "$CONFIG_DIR"/*.conf; do
  if [ -f "$file" ] && [ -r "$file" ]; then
    tmux source-file "$file"
  fi
done
