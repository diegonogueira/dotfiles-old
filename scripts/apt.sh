#!/usr/bin/env bash

echo ""
echo "=============================="
echo "Adding apt repositories"
echo "=============================="
echo ""

ppa_list=(
  alacritty,ppa:mmstick76/alacritty
  # speed-ricer,ppa:kgilmer/speed-ricer
)

for item in ${ppa_list[@]}
do
  repo=$(echo $item | cut -d',' -f1)
  repo_url=$(echo $item | cut -d',' -f2)

  echo ""
  echo "---- $repo ----"
  echo ""

  grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep $repo &> /dev/null

  if [ $? -eq 0 ]; then
    echo "Ok"
  else
    sudo add-apt-repository -y "$repo_url"
  fi
done

echo ""
echo "=============================="
echo "Updating apt"
echo "=============================="
echo ""

sudo apt update
sudo apt upgrade -y

echo ""
echo "=============================="
echo "Installig apt packages"
echo "=============================="
echo ""

apt_list=(
  # dependencies
  linux-headers-$(uname -r)
  build-essential
  libreadline-dev
  autoconf
  m4
  libncurses5-dev
  libwxgtk3.0-dev
  libgl1-mesa-dev
  libglu1-mesa-dev
  libpng-dev
  libssh-dev
  unixodbc-dev
  xsltproc
  fop
  dirmngr
  gpg
  libxft-dev
  #x11-utils
  # tools
  #inxi
  curl
  stow
  htop
  git
  git-flow
  gitk
  alacritty
  spotify
  snapd
  #feh
  nmap
  dbeaver-ce
  poedit
  zsh
  vim
  neovim
  python-pip
  python-neovim
  python3-neovim
  fzf
  silversearcher-ag
  #powertop
  #autokey-gtk
  gnome-tweaks
  dconf-editor
  #i3status
  #polybar
  tmux
  #deepin-screenshot
  timeshift
  #mbpfan
  #redshift
)

for item in ${apt_list[@]}
do
  echo ""
  echo "---- $item ----"
  echo ""

  dpkg -s $item &> /dev/null

  if [ $? -eq 0 ]; then
    echo "Ok"
  else
    sudo apt install -y "$item"
  fi
done
