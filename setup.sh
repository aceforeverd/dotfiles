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

_ROOT=$(dirname "$0")
cd "$_ROOT"

link_dotfile()
{
    local _file=$1
    if [ -e "$HOME/$_file" ]; then
        mv "$HOME/$_file" "$HOME/$_file.backup"
    fi
    ln -s "$_ROOT/$_file" "$HOME/$_file"
}

link_dotfile .tmux.conf
link_dotfile .bashrc
link_dotfile .zshrc

mkdir -p "$HOME"/.config/fish
ln -s "$_ROOT/.bundle/fishfile" "$HOME/.config/fish/fishfile"

echo "if test -r $_ROOT/.common/common.fish
    source $_ROOT/.common/common.fish
end" > "$HOME/.config/fish/config.fish"
