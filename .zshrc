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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
fi

if command -v zoxide > /dev/null ; then
  eval "$(zoxide init zsh)"
fi
if command -v pyenv > /dev/null ; then
    eval "$(pyenv init -)"
fi

if [ -e /home/ace/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ace/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
