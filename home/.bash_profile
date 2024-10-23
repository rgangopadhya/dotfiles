[ -r ~/.bashrc ] && source ~/.bashrc
# setup RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
# source ~/.profile
# handle go
export GOPATH=$HOME/dev/gotest
export PATH=$PATH:$GOPATH/bin

# Git Duet
export GIT_DUET_CO_AUTHORED_BY=1

# chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# add git completion
source ~/.git-completion.bash

# Set CLICOLOR if you want Ansi Colors in iTerm2 
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

pathadd() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}

# . ~/.nvm/nvm.sh

# git helpers

function clean-local-branches() {
  git checkout master && git pull && git branch --merged | grep -v "\*" | grep -v master | xargs -n 1 git branch -d
}

function clean-local-branches-new() {
  git checkout master17 && git pull && git branch --merged | grep -v "\*" | grep -v master17 | xargs -n 1 git branch -d
}

# handle pyenv stuff
if which pyenv > /dev/null; then 
	eval "$(pyenv init -)";
fi
if which pyenv-virtualenv-init > /dev/null; then 
	eval "$(pyenv virtualenv-init -)";
fi
# export PYENV_ROOT=/usr/local/var/pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$PYENV_ROOT/shims:$PATH

# Android stuff
export ANDROID_HOME="/Users/raja/Library/Android/sdk"
export ANDROID_SDK_ROOT="/Users/raja/Library/Android/sdk"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

export PATH
pathadd "/usr/local/bin"
pathadd "/Applications/Postgres.app/Contents/Versions/10/bin"
source ~/.git-prompt.sh
PS1="\[$Green\]\t\[$Red\]-\[$Blue\]\u\[$Yellow\]\[$Yellow\]\w\[\033[m\]\[$Purple\]\$(__git_ps1)\[$White\]\$ "

export PATH="$HOME/.yarn/bin:$PATH"

# REMIX stuff
export REMIX_HOME=/Users/raja/dev/remix
pathadd "$REMIX_HOME/bin"
pathadd "$REMIX_HOME/mobility-cloister/bin"

# for aws-vault
export AWS_ASSUME_ROLE_TTL="30m"

export VISUAL=nvim
export EDITOR="$VISUAL"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

. /usr/local/etc/profile.d/z.sh

alias gst="git status"
alias gc="git commit"
alias gco="git checkout"
alias gpull="git pull"
alias gpush="git p"

# edit bash prompts in vim mode
set -o vi

export PATH="$HOME/.poetry/bin:$PATH"
. "$HOME/.cargo/env"
