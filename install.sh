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

# create custom terminfo for emacs, to get true color support for terminal emacs
# for more info, see:
# https://www.gnu.org/software/emacs/manual/html_node/efaq/Colors-on-a-TTY.html
# this should work for emacs 26.1 and later
cat <<EOF > $emacsd/terminfo-custom.src
xterm-emacs|xterm with 24-bit direct color mode for Emacs,
  use=xterm-256color,
  setb24=\E[48\:2\:\:%p1%{65536}%/%d\:%p1%{256}%/%{255}%&\
     %d\:%p1%{255}%&%dm,
  setf24=\E[38\:2\:\:%p1%{65536}%/%d\:%p1%{256}%/%{255}%&\
     %d\:%p1%{255}%&%dm,
EOF
tic -x -o ~/.terminfo $emacsd/terminfo-custom.src
# acquire emacs version
emacs_version=$(dpkg -s emacs | grep Version: | grep -oP '(?<=\d\:).*(?=\+)')
# acquire major and minor emacs version
IFS=. read -r emacs_major emacs_minor <<< $emacs_version
emacs_major=$(($emacs_major+0))
emacs_minor=$(($emacs_minor+0))
# if emacs does not support true colors disable special commands in .bashrc
if [[ $emacs_major -le 26 && $emacs_minor -lt 1 ]]; then
    sed -i 's/TERM=xterm-emacs //g' $HOME/.bashrc
fi
# if emacs supports true colors natively, make concurrent modifications to .bashrc
if [[ $emacs_major -ge 27 && $emacs_minor -ge 1 ]]; then
    sed -i 's/TERM=xterm-emacs/TERM=xterm-direct/g' $HOME/.bashrc
fi

install_emacs_pkg() {
    if [ -z ${3+x} ]; then
	wget2file "${2}/${3}" "$emacsd/${1}_license"
    else
	wget2file "${2}/LICENSE" "$emacsd/${1}_license"	
    fi
    wget2dir "${2}/${1}.el" "$emacs_pkg/"
}

# install required emacs packages
install_emacs_pkg "dash" "magnars/dash.el/master"
install_emacs_pkg "autothemer" "jasonm23/autothemer/master"
install_emacs_pkg "neotree" "jaypei/emacs-neotree/dev"
install_emacs_pkg "markdown-mode" "jrblevin/markdown-mode/master" "LICENSE.md"
install_emacs_pkg "yaml-mode" "yoshiki/yaml-mode/master" "LICENSE.txt"

# install gruvbox
gruvbox_repo="greduan/emacs-theme-gruvbox/master"
install_emacs_pkg "gruvbox" "$gruvbox_repo"
wget2dir "$gruvbox_repo/gruvbox-dark-soft-theme.el" "$emacs_themes/"
wget2dir "$gruvbox_repo/gruvbox-dark-medium-theme.el" "$emacs_themes/"
wget2dir "$gruvbox_repo/gruvbox-dark-hard-theme.el" "$emacs_themes/"

# also install emacs configuration for root
sudo tic -x -o /root/.terminfo $emacsd/terminfo-custom.src
sudo cp $HOME/.emacs /root/
sudo cp -r $HOME/.emacs.d  /root/

