# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/ace/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="random"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    colored-man-pages
    gpg-agent
    docker
    docker-compose
    docker-machine
    composer
    last-working-dir
    golang
    rust
    gradle
    zsh-autosuggestions
    fast-syntax-highlighting
)

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

fpath+="$HOME/.config/zsh"

autoload -U compinit promptinit
autoload -U +X bashcompinit && bashcompinit
compinit
promptinit;

# util
function add_env_path {
    while [ $# -ge 1 ]; do
        [[ -d "$1" && ! "$PATH" == *$1* ]] && export PATH="$1":$PATH
        shift
    done
}

# Put your fun stuff here.
alias ls="ls -v --color=auto --group-directories-first"
alias ll="ls -al"
alias dbcli="dropbox-cli"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export COMPOSER_HOME="$HOME/.composer"

export GOPATH=$HOME/.go
GEM_PATH=$HOME/.gem/ruby/2.5.0
CARGO_HOME=$HOME/.cargo
YARN_HOME=$HOME/.config/yarn

export JAVA_OPTS="-Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=8118"

add_env_path \
    "$CARGO_HOME/bin" \
    "$GOPATH/bin" \
    "$GEM_PATH/bin" \
    "$YARN_HOME/bin" \
    "$HOME/.local/bin" \
    "$HOME/.luarocks/bin" \
    "$HOME/.dart-sdk/bin" \
    "$HOME/.pub-cache/bin" \

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# go get -u github.com/posener/complete/gocomplete
complete -o nospace -C /home/ace/.go/bin/gocomplete go

[ -r "$HOME/.composer/vendor/stecman/composer-bash-completion-plugin/hooks/zsh-completion" ] && \
    . "$HOME/.composer/vendor/stecman/composer-bash-completion-plugin/hooks/zsh-completion"
