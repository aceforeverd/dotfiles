#!/bin/zsh
# File              : common.zsh
# Date              : 24.11.2019
# Last Modified Date: 24.11.2019

function add_env_path() {
    while [ $# -ge 1 ]; do
        [[ -d "$1" && ! "$PATH" == *$1* ]] && export PATH="$1":$PATH
        shift
    done
}
