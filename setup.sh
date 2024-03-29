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

_ROOT=$(realpath "$(dirname "$0")" || pwd)

cd "$_ROOT"

link_dotfile()
{
    local _file=$1
    if [ -e "$HOME/$_file" ]; then
        mv "$HOME/$_file" "$HOME/$_file.backup"
        echo "old file $HOME/$_file backup to $HOME/$_file.backup"
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

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

link_dotfile '.tmux.conf'
link_dotfile '.bashrc'
link_dotfile '.zshrc'

link_dotfile '.config/fish/fish_plugins'
link_dotfile '.config/bat/config'
link_dotfile '.config/git/gitattributes'
link_dotfile '.config/alacritty/alacritty.yml'
link_dotfile '.config/kitty/kitty.conf'

cp .config/git/gitconfig ~/.gitconfig
echo -e "${GREEN}remember to update user info in $HOME/.gitconfig${NC}"

if [ -e "$HOME/.config/fish/config.fish" ]; then
    mv "$HOME/.config/fish/config.fish" "$HOME/.config/fish/config.backup"
fi

echo "if test -r $_ROOT/.common/common.fish
    source $_ROOT/.common/common.fish
end
test -e {\$HOME}/.iterm2_shell_integration.fish ; and source {\$HOME}/.iterm2_shell_integration.fish ; or true
" > "$HOME/.config/fish/config.fish"
