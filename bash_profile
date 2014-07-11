#!/bin/bash

########################################################################
# Bash Interactive Shell Setup
########################################################################

# Import the Z or Bash shell agnostic environment config
source ~/.profile


# When running two bash windows, allow both to write to the history, not one stomping the other
shopt -s histappend

#PROMPT_COMMAND='history -a'

# Larger bash history (allow 32³ entries; default is 500)
# export HISTSIZE=32768
# Unlimited history
export HISTSIZE=
export HISTFILESIZE=$HISTSIZE

# Remove duplicates from bash history
 export HISTCONTROL="ignoredups"
 export HISTIGNORE="&:ls:[bf]g:exit"

export HISTTIMEFORMAT="${RESET}${bo}${CDH}%d/%m/%Y${RESET}${bc} ${bo}${CHH}%H:%M:%S${RESET}${bc} "
# allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

# Keep multiline commands as one command in history
shopt -s cmdhist

# Load Matthew's Git bash prompt
 source ~/.dotfiles/bash_gitprompt

# Load Brew's git bash completion
# source /opt/boxen/homebrew/Cellar/git/1.9.1/etc/bash_completion.d/git-completion.bash
# source /opt/boxen/homebrew/Cellar/git/1.9.1/etc/bash_completion.d/git-prompt.sh
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
# GIT_PS1_SHOWDIRTYSTATE=true
