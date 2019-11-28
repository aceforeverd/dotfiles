#!/bin/bash
# File              : common.sh
# Date              : 24.11.2019
# Last Modified Date: 24.11.2019

function sf() {
    if [ "$#" -lt 1 ]; then
        echo "Supply string to search for!"
        return 1
    fi
    printf -v search "%q" "$*"
    include="yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
    exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
    rg_command='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "!{'$exclude'}/*"'
    files=$(eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}')
    [[ -n "$files" ]] && ${EDITOR:-vim} $files
}

add_env_path() {
    while [ $# -ge 1 ]; do
        if [[ -d "$1" && ! "$PATH" == *"$1"* ]]; then
            export PATH="$1":$PATH
        fi
        shift
    done
}

add_man_path() {
    while [ $# -ge 1 ]; do
        if [[ -d "$1" && ! "$MANPATH" == *"$1"* ]]; then
            export MANPATH="$1":$MANPATH
        fi
        shift
    done
}

add_info_path() {
    while [ $# -ge 1 ]; do
        if [[ -d "$1" && ! "INFOPATH" == *"$1"* ]]; then
            export INFOPATH="$1":$INFOPATH
        fi
        shift
    done
}


alias ls="ls -v --color=auto --group-directories-first"
alias l="ls -a"
alias ll="ls -al"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
