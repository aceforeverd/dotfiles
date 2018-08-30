if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

function sf {
    if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
    printf -v search "%q" "$*"
    include="yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
    exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
    rg_command='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "!{'$exclude'}/*"'
    files=`eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
    [[ -n "$files" ]] && ${EDITOR:-vim} $files
}

function add_env_path {
    while [ $# -ge 1 ]; do
        if [[ -d "$1" && ! "$PATH" == *"$1"* ]] ; then
            export PATH="$1":$PATH
        fi
        shift
    done
}

function add_man_path {
    while [ $# -ge 1 ] ; do
        if [[ -d "$1" && ! "$MANPATH" == *"$1"* ]] ; then
            export MANPATH="$1":$MANPATH
        fi
        shift
    done
}

function add_info_path {
    while [ $# -ge 1 ] ; do
        if [[ -d "$1" && ! "INFOPATH" == *"$1"* ]] ; then
            export INFOPATH="$1":$INFOPATH
        fi
        shift
    done
}

alias ls="ls -v --color=auto --group-directories-first"
alias l="ls -a"
alias ll="ls -al"
alias dbcli="dropbox-cli"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]] ; then
    export PINENTRY_USER_DATA="USER_CURSES=1"
fi

export COMPOSER_HOME="$HOME/.composer"
export GOPATH=$HOME/.go
GEM_PATH=$HOME/.gem/ruby/2.5.0
CARGO_HOME=$HOME/.cargo
NPM_HOME=$HOME/.npm_global
YARN_HOME=$HOME/.config/yarn
export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale
export JAVA_OPTS="-Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=8118"
export HADOOP_HOME=/opt/hadoop-2.9.1
export HADOOP_COMMON_LIB_NATIVE_DIR=/opt/hadoop-2.9.1/lib/native

add_env_path "$NPM_HOME/bin" \
    "$CARGO_HOME/bin" \
    "$GOPATH/bin" \
    "$GEM_PATH/bin" \
    "$YARN_HOME/bin" \
    "$HOME/.local/bin" \
    "$HOME/.luarocks/bin" \
    "$HOME/.dart-sdk/bin" \
    "$HOME/.pub-cache/bin" \
    "$COMPOSER_HOME/vendor/bin" \

PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\$\[\033[00m\] '

for sh in ~/.local/share/bash-completion/*.bash ; do
    [ -r "$sh" ] && . "$sh"
done

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# go get -u github.com/posener/complete/gocomplete
complete -C /home/ace/.go/bin/gocomplete go

COMPOSER_COMPLETE="$HOME/.composer/vendor/stecman/composer-bash-completion-plugin/hooks/bash-completion"
[ -r "$COMPOSER_COMPLETE" ] && . "$COMPOSER_COMPLETE"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.bash.inc' ]; then source '/opt/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.bash.inc' ]; then source '/opt/google-cloud-sdk/completion.bash.inc'; fi
