
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/raja/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# chruby
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh

# Add git completion
fpath=(~/.zsh $fpath)

pathadd() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}

function clean-local-branches() {
  git checkout master && git pull && git branch --merged | grep -v "\*" | grep -v master | xargs -n 1 git branch -d
}

# PG config
export PGHOST="localhost"
eval "$(/opt/homebrew/bin/brew shellenv)"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/openssl@1.1/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openssl@1.1/include"

# handle pyenv stuff
# Handle x86 vs arm64 pyenv installs
if [[ $(arch) != arm64* ]]
then
	eval "$(/usr/local/bin/brew shellenv)"
	export PYENV_ROOT="$HOME/.pyenv-x86"
else
	eval "$(/opt/homebrew/bin/brew shellenv)"
	# default PYENV_ROOT => $HOME/.pyenv
fi

if which pyenv > /dev/null; then 
	eval "$(pyenv init -)";
fi
if which pyenv-virtualenv-init > /dev/null; then 
	eval "$(pyenv virtualenv-init -)";
fi
# export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$PYENV_ROOT/shims:$PATH

export PATH
pathadd "/usr/local/bin"
# pathadd "/Users/raja/.gem/ruby/3.1.4/bin"
source ~/.git-prompt.sh

export PATH="$HOME/.yarn/bin:$PATH"

# REMIX stuff
export REMIX_HOME=/Users/raja/dev/remix
pathadd "$REMIX_HOME/bin"

# for aws-vault
export AWS_ASSUME_ROLE_TTL="1hr"

export VISUAL=nvim
export EDITOR="$VISUAL"

. /usr/local/etc/profile.d/z.sh

alias gst="git status"
alias gc="git commit"
alias gco="git checkout"
alias gpull="git pull"
alias gpush="git p"

# edit bash prompts in vim mode
set -o vi

export PATH="/Applications/Racket v8.0/bin:$PATH"

 # PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} %D %T % %{$reset_color%}'
 #
DISABLE_UNTRACKED_FILES_DIRTY="true"

export AWS_SDK_LOAD_CONFIG=1
export HOMEBREW_NO_AUTO_UPDATE=1

# go setup
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export GO111MODULE=on

[[ -s "/Users/raja/.gvm/scripts/gvm" ]] && source "/Users/raja/.gvm/scripts/gvm"
gvm use 1.17 > /dev/null

# TFENV fix for M1: specify the arch, otherwise the versions
# of terraform we try to install will fail
export TFENV_ARCH=amd64
# https://stackoverflow.com/questions/70407525/terraform-gives-errors-failed-to-load-plugin-schemas/71571521#71571521
export GODEBUG=asyncpreemptoff=1;

# M1 fix for OPENBLAS
export OPENBLAS="/opt/homebrew/opt/openblas"
# M1 fix for R-tree libspatialindex
export SPATIALINDEX_C_LIBRARY="/opt/homebrew/opt/spatialindex/lib"
# Ensure docker images built properly for ECS
# export DOCKER_DEFAULT_PLATFORM=linux/amd64
unset DOCKER_DEFAULT_PLATFORM

export LOKALISE_API=cd4cd75bbebfc8cd33687ee7ed033505cdb16e66
export CIRCLECI_TOKEN=90d636eecc94d1ce4a32b03012b84bd17ccc7678

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# M1 fix for Coinlib overrides, from 
# https://paper.dropbox.com/doc/Remix-monorepo-setup-on-M1-Mac--BzTSILxAQ1iqJcFiD~ApkrmtAg-EP8ixHdDwhBUfDxgxjgfM#:h2=Cbc
COIN_LIB=~/lib/coin
export PMIP_CBC_LIBRARY=$COIN_LIB/lib/libCbc.dylib
export PKG_CONFIG_PATH=$COIN_LIB/lib/pkgconfig

# Rust
export PATH="/Users/raja/.cargo/bin/:$PATH"

export COLIMA_MEMORY=10
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"

export NODE_OPTIONS=--openssl-legacy-provider
# https://ridewithvia.slack.com/archives/C01QULD49L1/p1687839941302479?thread_ts=1686263920.891189&cid=C01QULD49L1
export PGGSSENCMODE=disable

# export NIXPKGS_ALLOW_INSECURE=1

# Hook direnv into your shell
# We need to add this to ~/.zshrc, as MacOS updates remove these lines from the
# `/etc/zshrc` file, making nix not work.
# See https://gist.github.com/meeech/0b97a86f235d10bc4e2a1116eec38e7e
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

eval "$(direnv hook zsh)"

GIT_PATH=$(which git)

git() {
    if [[ $PWD == $REMIX_HOME* ]]; then
      direnv exec $REMIX_HOME $GIT_PATH $@
    else
      $GIT_PATH $@
    fi
}

rubocop() {
  if [[ $PWD == $REMIX_HOME* ]]; then
    direnv exec $REMIX_HOME rubocop $@
  else
    $GEM_HOME/bin/rubocop $@
  fi
}

# End Nix

