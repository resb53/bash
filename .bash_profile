# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

# Git autocomplete
if [ -f /etc/bash_completion.d/git ]; then
  . /etc/bash_completion.d/git

# If not there, try here (on Mint/Ubuntu/Debian?)
elif [ -f /usr/share/bash-completion/completions/git ]; then
  . /usr/share/bash-completion/completions/git

fi

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
