#!/bin/bash

# variables
terminal=${PWD}/conf/terminal

# functions
request () {
    echo
    while true; do
        read -p "Install/configure $1 [Y/n] " yn
        case $yn in y|Y|yes ) return 0;; n|N|no ) return 1;; * ) echo "Please answer yes or no.";; esac
    done
}

if request "bash"; then
    cp ${terminal}/.bashrc ${terminal}/.profile ${terminal}/.bash_aliases $HOME/.
fi

if request "Xfce terminal"; then 
    mkdir -p $HOME/.config/xfce4/terminal
    cp ${terminal}/terminalrc $HOME/.config/xfce4/terminal/.
fi

# configure emacs
if request "emacs"; then
    . ${PWD}/scrips/emacs.sh
fi
