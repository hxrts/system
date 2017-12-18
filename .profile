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

<<<<<<< HEAD
<<<<<<< HEAD
alias tree="tree -C"
=======
alias tree='tree -C'
>>>>>>> arrange files by function
=======
alias tree='tree -C'
>>>>>>> bdb3cfd... arrange files by function
alias ls='ls -ha --color=auto'
alias open='gnome-open'
alias grep='grep --color'
alias nix-search='nix-env -qa | grep'
<<<<<<< HEAD
<<<<<<< HEAD

#--------
# haskell
#--------

=======

function volume { pactl -- set-sink-volume 0 $1'%'; }

#--------
# haskell
#--------

>>>>>>> arrange files by function
=======

function volume { pactl -- set-sink-volume 0 $1'%'; }

#--------
# haskell
#--------

>>>>>>> bdb3cfd... arrange files by function
alias haskpkgs='nix-env -f "<nixpkgs>" -qaP -A haskellPackages'
export PATH="$PATH:$HOME/.cabal/bin"

#----
# ssh
#----

export SSH_KEY_PATH='~/.ssh/id_rsa'

#-----------------
# remote locations
#-----------------

# terra > mosh hxrts@terra.hxrts.com'
alias terra='terra.hxrts.com'
export terra='terra.hxrts.com'

# juno > ssh admin@juno.hxrts.com'
alias juno='juno.hxrts.com'
export juno='juno.hxrts.com'

# io > mosh root@165.227.91.157
alias io='165.227.91.157'
export io='165.227.91.157'

# supertemporal >
alias supertemporal='ssh -i ~/.ssh/supertemporal_id_rsa hxrts@supertempor.al'

# hal > ssh -i ~/.ssh/id_rsa bermans@hal.cbio.mskcc.org
alias hal='ssh -i ~/.ssh/id_rsa bermans@hal.cbio.mskcc.org'

#-----
# tmux
#-----

if [[ $(ps -e | grep -v "grep" | grep -q tmux) && "$TERM" != "dumb" ]]; then
	echo "";
	tmux ls;
fi
