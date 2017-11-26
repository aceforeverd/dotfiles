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

alias ls="ls -v --color=auto --group-directories-first"
alias ll="ls -al"
alias dbcli="dropbox-cli"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

export GOPATH=$HOME/.go
GEM_PATH=$HOME/.gem/ruby/2.4.0
CARGO_HOME=$HOME/.cargo
NPM_HOME=$HOME/.npm_global
YARN_HOME=$HOME/.config/yarn

add_env_path "$NPM_HOME/bin" \
    "$CARGO_HOME/bin" \
    "$GOPATH/bin" \
    "$GEM_PATH/bin" \
    "$YARN_HOME/bin" \
    "$HOME/.local/bin"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export SASS_LIBSASS_PATH=~/Git/libsass/
export SASS_SPEC_PATH=~/Git/sass-spec/
export GPG_TTY=$(tty)

export PYTHONPATH=$HOME/.local/lib64/python3.4/site-packages/:$HOME/.local/lib64/python3.6/site-packages


#export XMODIFIERS="@im=fcitx"
#export QT_IM_MODULE=fcitx
#export GTK_IM_MODULE=fcitx

PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\$\[\033[00m\] '

for sh in ~/.local/share/bash-completion/*.bash ; do
    [ -r "$sh" ] && . "$sh"
done

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
