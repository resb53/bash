#!/usr/bin/bash

# Get install file directory
scriptdir=$(dirname "$(realpath $0)")

for f in .bash_profile .bashrc .gitconfig .git_ps1_detail.bash .vimrc
do
  echo "Linking $scriptdir/$f to ~/$f"
  ln -sf $scriptdir/$f ~/$f
done
