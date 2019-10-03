#!/usr/bin/env bash

echo ""
echo "=============================="
echo "Stowing /home"
echo "=============================="
echo ""

remove_list=(
  ~/.config/alacritty
  ~/.config/i3
  ~/.zshrc
  ~/.config/autokey
)

for item in ${remove_list[@]}
do
  echo ""
  echo "---- removing $item ----"
  echo ""
  rm -rf ${item}
done

stow_list=(
  git
  tmux
  zsh
  vim
  nvim
  shell
  htop
  autokey
  alacritty-${DEVICE}-${WM}
)

if [[ "$WM" == "i3wm" ]]; then
  stow_wm_list=(
    i3
    polybar
    redshift
    compton
    dunst
  )

  stow_list=( `echo ${stow_list[@]}` `echo ${stow_wm_list[@]}` )
fi

if [[ "$OS" == "arch" ]]; then
  stow_linux_list=(
    gtk-3
  )

  stow_list=( `echo ${stow_list[@]}` `echo ${stow_linux_list[@]}` )
fi

for item in ${stow_list[@]}
do
  echo ""
  echo "---- stowing $item ----"
  echo ""
  stow -v ${item}
done

if [[ "$OS" != "osx" ]]; then
  echo ""
  echo "=============================="
  echo "Stowing /etc"
  echo "=============================="
  echo ""

  remove_list=(
    /etc/lightdm/lightdm.conf
  )

  for item in ${remove_list[@]}
  do
    echo ""
    echo "---- removing $item ----"
    echo ""
    sudo rm -rf ${item}
  done

  stow_list=(
    etc-${DEVICE}
  )

  for item in ${stow_list[@]}
  do
    echo ""
    echo "---- stowing /etc $item ----"
    echo ""
    sudo stow -v ${item} -t /etc
  done
fi

