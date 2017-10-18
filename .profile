# all shell instances

#-----
# path
#-----

# ruby version manager
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # load RVM as function

# miniconda
export PATH="~/miniconda3/bin:$PATH"

# local apps
export PATH="$PATH:$HOME/bin"

#-----------------------
# app aliases & defaults
#-----------------------

# tree coloring
alias tree="tree -C"

#------------------
# platfom targeting
#------------------

#export CLICOLOR=1
#export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
alias ls='ls -ha --color=auto'


#----
# ssh
#----

export SSH_KEY_PATH='~/.ssh/id_rsa'

#-----------------
# remote locations
#-----------------

# hxrts alias
alias terra='mosh hxrts@terra.hxrts.com'
alias juno='ssh admin@juno.hxrts.com'
alias io='mosh hxrts@192.241.143.63'
alias supertemporal='ssh -i ~/.ssh/supertemporal_id_rsa hxrts@supertempor.al'

# lab aliases
alias hal='ssh -i ~/.ssh/id_rsa bermans@hal.cbio.mskcc.org'
alias saba='ssh -i ~/.ssh/saba.private bermans@saba2.cbio.mskcc.org'
alias ika='ssh -i ~/.ssh/saba.private bermans@ika.cbio.mskcc.org'


#-----
# tmux
#-----

if [[ $(ps -e | grep -v "grep" | grep -q tmux) && "$TERM" != "dumb" ]]; then
	echo "";
	tmux ls;
fi

