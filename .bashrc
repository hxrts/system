# interactive non-login instances

#----------
# bash init
#----------

# if not running interactively, continue
[ -z "$PS1" ] && return

#--------
# options
#--------

# no duplicate lines in history
HISTCONTROL=ignoreboth

# append to history file
shopt -s histappend

# check window size after commands & update LINES, COLUMNS
shopt -s checkwinsize

# history length
HISTSIZE=1000
HISTFILESIZE=2000

#-----------------------
# app aliases & defaults
#-----------------------

# shell vi mode
set -o vi

source ~/.profile
source ~/.local_profile
