#!/bin/bash
# setup.sh
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

set -eE
set -o nounset

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [ "$OSTYPE" = "linux-gnu" ]; then
    _ROOT=$(realpath "$(dirname "$0")")
else
    _ROOT=.
fi

cd "$_ROOT"

link_dotfile()
{
    local _file=$1
    if [ -e "$HOME/$_file" ]; then
        mv "$HOME/$_file" "$HOME/$_file.backup"
    fi

    local _dir
    _dir="$HOME/$(dirname "$_file")"
    if [[ "$_dir" != '.' && ! -d "$_dir" ]]; then
        echo -e "${GREEN} creating directory $_dir${NC}"
        mkdir -p "$_dir"
    fi
    ln -s "$_ROOT/$_file" "$HOME/$_file"
    echo -e "${GREEN}setted $_file ${NC}"
}

link_dotfile '.tmux.conf'
link_dotfile '.bashrc'
link_dotfile '.zshrc'

link_dotfile ".config/fish/fish_plugins"
link_dotfile '.config/bat/config'

echo "if test -r $_ROOT/.common/common.fish
    source $_ROOT/.common/common.fish
end" > "$HOME/.config/fish/config.fish"
