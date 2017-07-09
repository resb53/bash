# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Set user and mask
USER=$(whoami)
umask 0002

# Git prompt details
source ~/.git_ps1_detail.bash
source ~/.git_completion.bash

# Set prompt to dynamic update
export PROMPT_COMMAND="echo -ne \"\033]0;${USER}@$(hostname | cut -d'.' -f'1') -- $(ddate +'%{%A, the %e day of %B%}, %Y.%N Celebrate %H')\007\""
export PS1='\033[00;96m$(date +%s) \033[00;36m[\u@\h] \033[00;96m${PWD}$(__git_ps1_detail)\n$ '

# User specific exports
export KERN_DIR=/usr/src/kernels/`uname -r`
export SHELL=/bin/bash
export EDITOR=vim
export HISTFILESIZE=10000
export CHARSET="utf8"
export LANG="en_GB.UTF-8"
export TZ="UTC"

# Set Go vars
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# User specific aliases
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias ls="ls --color=auto"
alias ll="ls -lahF"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias hex="/usr/bin/od -A x -t x1z -v"
