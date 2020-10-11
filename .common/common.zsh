#!/bin/bash
# .common/common.zsh
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

function add_env_path() {
    while [ $# -ge 1 ]; do
        [[ -d "$1" && ! "$PATH" == *$1* ]] && export PATH="$1":$PATH
        shift
    done
}

alias ls="ls -v --color=auto --group-directories-first"
alias ll="ls -al"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

export GPG_TTY=$(tty)

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi
