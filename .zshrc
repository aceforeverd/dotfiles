#!/bin/zsh
# zshrc example
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


# Proxys
# PROXY_URL=http://127.0.0.1:$PORT
# export ALL_PROXY=$PROXY_URL
# export HTTP_PROXY=$PROXY_URL
# export HTTPS_PROXY=$PROXY_URL
# export NO_PROXY=127.0.0.1

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

COMMON_PATH=$HOME/.dotfiles/.common/common.zsh
if [ -r "$COMMON_PATH" ] ; then
	. "$COMMON_PATH"

	# custom path
	# add_env_path
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

TRAPWINCH() {
  zle && { zle reset-prompt; zle -R }
}
