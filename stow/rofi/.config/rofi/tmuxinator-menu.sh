#!/bin/bash
# Start tmuxinator menu

declare -nc options=("$(
  ls .config/tmuxinator |
  grep .yml |
  sed -e 's/.yml//g'
)")

choice=$(echo -e "${options[@]}" | rofi -dmenu -i -p 'Select the project')

if [[ -f ~/.config/tmuxinator/${choice}.yml ]]; then
  exec alacritty -e $SHELL -c "~/.asdf/shims/tmuxinator start -p ~/.config/tmuxinator/$choice.yml"
fi
