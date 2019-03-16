#------------
# environment
#------------

if [[ -z $PS1 ]]; then return; fi
if [[ -n $IN_NIX_SHELL ]]; then return; fi

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

export WINEPREFIX="/home/$USER/prefix32"

#-----------------------
# app aliases & defaults
#-----------------------

alias tree='tree -C'
alias ls='ls -h -a --color=auto'
alias open='xdg-open'
alias grep='grep --color'
alias ps='ps -e'
alias nix-search='nix-env -qaP | grep -i'
alias nix-search-node='nix-env -qaPA "nixos.nodePackages" | grep -i'
alias nix-search-haskell='nix-env -qaPA "nixos.haskellPackages" | grep -i'
alias nix-rebuild='sudo nixos-rebuild switch'
alias nix-update='(cd ~/nixpkgs && git fetch && git rebase)'
alias nix-install='nix-env -iA'
alias nix-uninstall='nix-env --uninstall'
alias getip='ip route get 1 | awk '"'"'{print $NF;exit}'"'"
alias xclip='xclip -selection c'
alias end='pkill -f'
alias on='ping -c 1 www.google.com > /dev/null && echo "true"'
alias network='nmtui'
alias network-rescan='nmcli device wifi rescan && nmtui'
alias external-display='xrandr | grep "HDMI1 connected" && xrandr --output eDP1 --auto --output HDMI1 --auto --left-of eDP1'
alias xclip='xclip -selection c'

# https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1722478
alias scrollfix='sudo modprobe -r psmouse && sudo modprobe psmouse'

#----------------
# hardware config
#----------------

# prevent display sleep
xset s off -dpms

# volume settings
function volume { pactl -- set-sink-volume 0 $1'%'; }

#--------
# haskell
#--------

export PATH="$PATH:$HOME/.cabal/bin"

#----
# ssh
#----

export SSH_KEY_PATH='~/.ssh/id_rsa'

#-----------------
# remote locations
#-----------------

# leda > et hxrts@46.101.208.18
export leda='46.101.208.18'
alias leda='et hxrts@46.101.208.18'

# terra > mosh hxrts@terra.hxrts.com'
export terra='104.236.26.234'
alias terra='mosh hxrts@104.236.26.234'

# juno > ssh admin@juno.hxrts.com'
export juno='juno.hxrts.com'
alias juno='ssh hxrts@juno.hxrts.com'

# io > mosh hxrts@165.227.91.157
export io='165.227.91.157'
alias io='mosh hxrts@165.227.91.157'

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
