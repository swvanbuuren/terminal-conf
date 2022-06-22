#!/bin/bash

# functions
wget_github() { wget https://raw.githubusercontent.com/$1 $2; }
wget2file() { wget_github "$1" "-O $2"; }
wget2dir() { wget_github "$1" "-P $2"; }

# variables
terminal=${PWD}/conf/terminal
emacs=${PWD}/conf/emacs
emacsd=$HOME/.emacs.d
emacs_pkg=$emacsd/el
emacs_themes=$emacsd/themes

# configure bash
cp ${terminal}/.bashrc ${terminal}/.profile $HOME/.

# configure xfce terminal
mkdir -p $HOME/.config/xfce4/terminal
cp ${terminal}/terminalrc $HOME/.config/xfce4/terminal/.

# configure emacs
sudo apt install emacs wget  # make sure wget and emacs are installed
cp ${emacs}/.emacs $HOME/.

# create directories
mkdir -p $emacs_pkg
mkdir -p $emacs_themes

install_emacs_pkg() {
    wget2file "${2}/LICENSE" "$emacsd/${1}_license"
    wget2dir "${2}/${1}.el" "$emacs_pkg/"
}

# install required emacs packages
install_emacs_pkg "dash" "magnars/dash.el/master"
install_emacs_pkg "autothemer" "jasonm23/autothemer/master"
install_emacs_pkg "neotree" "jaypei/emacs-neotree/dev"

# install gruvbox
gruvbox_repo="greduan/emacs-theme-gruvbox/master"
install_emacs_pkg "gruvbox" "$gruvbox_repo"
wget2dir "$gruvbox_repo/gruvbox-theme.el" "$emacs_themes/"

