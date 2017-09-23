# Get git-prompt source if not already included
# CentOS/Fedora
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
# Mint/Ubuntu/Debian
elif [ -f /etc/bash_completion.d/git-prompt ]; then
  source /etc/bash_completion.d/git-prompt 
fi

# Global prompt colours
cDEF=$'\e[0;32m' #dark green
cNONE=$'\e[0m'   #default

# Colour prompt strings (ARG1:String, ARG2:Colour)
function colourify() {
  local cRED=$'\e[0;31m'
  local cORANGE=$'\e[0;33m'
  local cYELLOW=$'\e[0;93m'
  local cGREEN=$'\e[0;92m'

  case $2 in
    red)
      echo $cRED$1$cDEF
      ;;
    orange)
      echo $cORANGE$1$cDEF
      ;;
    yellow)
      echo $cYELLOW$1$cDEF
      ;;
    green)
      echo $cGREEN$1$cDEF
      ;;
  esac
}

function __git_ps1_detail() {

  local BRANCH_STRING=$cDEF
  local GIT_ROOT=$(__gitdir)/..
  local GIT_BRANCH=$(__git_ps1 "%s")

  STATUS=$(git status -su 2> /dev/null)
  if [ "$?" -eq 0 ]; then
    # Any untracked changes to files
    UNTRK=$(echo "$STATUS" | grep -e "^??" 2> /dev/null | wc -l)
    # Any changes to tracked files
    CHNGE=$(echo "$STATUS" | grep -e "^[MADRCU? ][MD]" 2> /dev/null | wc -l)
    # Any uncommitted changes
    UNCOM=$(echo "$STATUS" | grep -e "^[MADRCU?] " 2> /dev/null | wc -l)
    # Total tracked files
    TRACK=`(cd $GIT_ROOT; git ls-tree -r $GIT_BRANCH 2> /dev/null | wc -l)`
    # If new repo, no committed/tracked files
    if [ "$?" -ne 0 ]; then
      TRACK=0
    fi
    
    # Get remote repo name
    REPO=$(git remote -v | grep -m1 origin | grep -oe "[^\/]*\.git" | cut -d"." -f"1")
    # Get local dir name for this git repo if no remote
    if [ -z $REPO ]; then
      REPO=`(cd $GIT_ROOT; pwd | grep -oe "[^\/]*$")`
    fi

    # Provides the branch name and 4 colon separated numbers.
    # Changes propagate from left to right as follows:
    # Red:    New files that aren't tracked.
    # Orange: Tracked files that have uncommitted changes.
    # Yellow: Files staged for committing.
    # Green:  Total tracked files in the repo.
    BRANCH_STRING+=" [$REPO/$GIT_BRANCH:"$(colourify $UNTRK 'red'):$(colourify $CHNGE 'orange'):$(colourify $UNCOM 'yellow'):$(colourify $TRACK 'green')"]"
  fi

  BRANCH_STRING+=$cNONE

  echo $BRANCH_STRING

}
