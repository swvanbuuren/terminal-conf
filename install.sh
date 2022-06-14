#!/bin/bash

terminal=${PWD}/conf/terminal/
emacs=${PWD}/conf/terminal/

# configure bash
cp ${terminal}/.bashrc ${terminal}/.profile $HOME/.

# configure xfce terminal
mkdir -p $HOME/.config/xfce4/terminal
cp ${terminal}/terminalrc $HOME/.config/xfce4/terminal/.

# configure emacs
sudo apt install emacs wget  # make sure wget and emacs are installed
cp ${emacs}/.emacs $HOME/.
mkdir -p $HOME/.emacs.d/themes
wget https://raw.githubusercontent.com/greduan/emacs-theme-gruvbox/master/gruvbox-theme.el -P $HOME/.emacs.d/themes/
wget https://raw.githubusercontent.com/jaypei/emacs-neotree/dev/neotree.el -P $HOME/.emacs.d/el/

