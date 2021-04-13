#!/bin/bash
# .common/common.bash
# Copyright (c) 2020 Ace <teapot@aceforeverd.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

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

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi

if [[ $OSTYPE = 'linux-gnu' ]]; then
    alias ls="ls -v --color=auto --group-directories-first"
elif [[ $OSTYPE = "darwin"* ]]; then
    alias ls="ls -v -G"
fi
alias l="ls -a"
alias ll="ls -al"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

export GPG_TTY=$(tty)
