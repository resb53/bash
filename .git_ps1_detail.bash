# Get git-prompt source if not already included
# CentOS/Fedora
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
# Mint/Ubuntu/Debian
elif [ -f /etc/bash_completion.d/git-prompt ]; then
  source /etc/bash_completion.d/git-prompt 
fi

function __git_ps1_detail() {

  BRANCH_STRING=''
  STATUS=$(git status -s 2> /dev/null)
  
  if [ "$?" -eq 0 ]; then
    # Any untracked changes to files
    UNTRK=$(echo $STATUS | grep -e "^??" 2> /dev/null | wc -l)
    # Any changes to tracked files
    CHNGE=$(echo "$STATUS" | grep -e "^[MADRCU? ][MD]" 2> /dev/null | wc -l)
    # Any uncommitted changes
    UNCOM=$(echo "$STATUS" | grep -e "^[MADRCU?] " 2> /dev/null | wc -l)
    # Total tracked files
    TRACK=$(git ls-files | wc -l)
    
    # Provides the branch name and 4 colon separated numbers.
    # Changes propagate from left to right as follows:
    # Red:    New files that aren't tracked.
    # Orange: Tracked files that have uncommitted changes.
    # Yellow: Files staged for committing.
    # Green:  Total tracked files in the repo.
    BRANCH_STRING+=$'\033[0;32m'$(__git_ps1 " [%s:")$'\033[0;31m'${UNTRK}$'\033[0;32m':$'\033[0;33m'${CHNGE}$'\033[0;32m':$'\033[0;93m'${UNCOM}$'\033[0;32m':$'\033[0;92m'${TRACK}$'\033[0;32m]'$'\033[0m'

  else
    # Not a git repo or git not installed
    BRANCH_STRING+=$'\033[0m'
  fi

  echo ${BRANCH_STRING}

}
