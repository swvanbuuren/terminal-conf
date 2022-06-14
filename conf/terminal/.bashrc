# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

TERM=xterm-256color
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# for showing the current git branch
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'
}

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;32m\]\u\[\033[00;32m\]@\h\[\033[01;34m\] \w \[\033[31m\]$(parse_git_branch)\[\033[00m\] \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch) \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# for common 256 color terminals (e.g. gnome-terminal)
export TERM=xterm-256color

# some more ls aliases
alias la='ls -A'
alias ls='ls --color=auto -ahF'
alias ll='ls --color=auto -lahF'
alias l='ll'
alias 'cd..'='cd ..'
alias '..'='cd ..'
alias emacs='emacs -nw'
alias emasc='emacs -nw'
alias eamcs='emacs -nw'
alias emcas='emacs -nw'
alias emcsa='emacs -nw'
alias 'sudoemacs'='sudo emacs -nw'
alias 'ipscan'='sudo arp-scan --interface=eth0 --localnet'
alias pip=pip3

activate_venv () {
    . /mnt/storage/work/python/00__venvs/$1/bin/activate
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# add auto to the PATH
# source /mnt/storage/software/auto/07p/cmds/auto.env.sh

# add texlive 201x to the PATH, MANPATH and the INFOPATH
# export PATH=/usr/local/texlive/2018/bin/x86_64-linux:$PATH
# export MANPATH=/usr/local/texlive/2018/texmf-dist/doc/man:$MANPATH
# export INFOPATH=/usr/local/texlive/2018/texmf-dist/doc/info:$INFOPATH
# unset TEXINPUTS
# unset TEXMFCONFIG

# add own scripts to the path
export PATH=/home/sietze/bin:$PATH
export PATH=/home/sietze/.local/bin:$PATH

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/keepassxc-libs/lib/x86_64-linux-gnu
export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH
