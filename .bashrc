# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion

# Set user and mask
USER=$(whoami)
umask 0002

# Git prompt details
source ~/.git_ps1_detail.bash
source ~/.git_completion.bash

# Set prompt to dynamic update
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@$(hostname | cut -d"." -f"1")$(if $(ddate > /dev/null 2> /dev/null); then echo " -- $(ddate +"%{%A, the %e day of %B%}, %Y.%N Celebrate %H")"; fi)\007"'
export PS1='\033[00;96m$(date +%s) \033[00;36m[\u@\h] \033[00;96m${PWD}$(__git_ps1_detail)\n$ '

# User specific exports
export KERN_DIR=/usr/src/kernels/`uname -r`
export SHELL=/bin/bash
export EDITOR=vim
export HISTFILESIZE=10000
export CHARSET="utf8"
export LANG="en_GB.UTF-8"
export TZ="UTC"
export SSH_ASKPASS="/usr/bin/ksshaskpass"

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

# Set helpful container parameters
alias dockerclean="docker ps -a | grep Exit | awk '{print \$1}' | xargs docker rm"
alias dockerclear="docker images | grep '^<none>' | awk '{print \$3}' | xargs docker rmi"
export CONTAINER_RUNTIME_ENDPOINT=unix:///var/run/crio/crio.sock
alias criclean="sudo crictl ps -a | grep Exit | awk '{print \$1}' | xargs sudo crictl rm"
alias criclear="sudo crictl images | grep '^<none>' | awk '{print \$3}' | xargs sudo crictl rmi"
