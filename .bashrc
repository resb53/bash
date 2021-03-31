# .bashrc

# If not running interactively, do nothing
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=10000

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    COMPLETION=1
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    COMPLETION=1
    . /etc/bash_completion
  fi

  if [ $COMPLETION ]; then
    if [ -x "$(command -v kubectl)" ]; then
      source <(kubectl completion bash)
    fi
    # Git prompt details after forcing load of git autocompletion
    source /usr/share/bash-completion/completions/git
    source ~/.git_ps1_detail.bash
  fi
fi

# Set user and mask
USER=$(whoami)
umask 0002

# Set prompt to dynamic update
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@$(hostname | cut -d"." -f"1")$(if $(ddate > /dev/null 2> /dev/null); then echo " -- $(ddate +"%{%A, the %e day of %B%}, %Y.%N Celebrate %H")"; fi)\007"'
export PS1='\033[00;96m$(date +%s) \033[00;36m[\u@\h] \033[00;96m${PWD}$(__git_ps1_detail)\n$ '

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# User specific exports
export KERN_DIR=/usr/src/kernels/`uname -r`
export SHELL=/bin/bash
export EDITOR=vim
export CHARSET="utf8"
export LANG="en_GB.UTF-8"
export TZ="UTC"
export SSH_ASKPASS="/usr/bin/ksshaskpass"

# Set Go vars
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# User specific aliases
# alias cp="cp -i"
# alias mv="mv -i"
# alias rm="rm -i"
alias ll="ls -lahF"
alias la="ls -A"
alias hex="/usr/bin/od -A x -t x1z -v"

# Enable Colour Support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Set helpful container parameters
alias dockerclean="docker ps -a | grep Exit | awk '{print \$1}' | xargs docker rm"
alias dockerclear="docker images | grep '^<none>' | awk '{print \$3}' | xargs docker rmi"
export CONTAINER_RUNTIME_ENDPOINT=unix:///var/run/crio/crio.sock
alias criclean="sudo crictl ps -a | grep Exit | awk '{print \$1}' | xargs sudo crictl rm"
alias criclear="sudo crictl images | grep '^<none>' | awk '{print \$3}' | xargs sudo crictl rmi"
