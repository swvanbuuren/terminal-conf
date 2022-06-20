#!/bin/bash

# functions
wget_github() { wget https://raw.githubusercontent.com/$1 $2 }
wget2file() { wget_github $1 -O $2 }
wget2dir() { wget_github $1 -P $2 }

# variables
terminal=${PWD}/conf/terminal/
emacs=${PWD}/conf/terminal/
emacsd=$HOME/.emacs.d/
emacs_pkg=$emacsd/el/
emacs_themes=$emacsd/themes/

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

# install gruvbox
gruvbox_repo="greduan/emacs-theme-gruvbox/master"
wget2file "$gruvbox_repo/LICENSE" "$emacsd/gruvbox_license"
wget2dir "$gruvbox_repo/gruvbox.el" "$emacs_pkg/"
wget2dir "$gruvbox_repo/gruvbox-theme.el" "$emacs_themes/"

# install neotree
neotree_repo="jaypei/emacs-neotree/dev"
wget2file "$neotree_repo/LICENSE" "$emacsd/neotree_license"
wget2dir "$neotree_repo/neotree.el" "$emacs_pkg/"

