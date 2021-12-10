#!/bin/bash

# Copyright (C) 2020  Ace <teapot@aceforeverd.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -eE
set -o nounset

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [ $# -eq 0 ] ; then
    echo "A path is required"
    exit 1
fi

if [ ! -d "$1" ] ; then
    echo "$1 is not a directory"
    exit 1
fi

_REMOUNT_ROOT=$1

sudo mount --rbind /dev "$_REMOUNT_ROOT/dev"
sudo mount --make-rslave "$_REMOUNT_ROOT/dev"
sudo mount -t proc /proc "$_REMOUNT_ROOT/proc"
sudo mount --rbind /sys "$_REMOUNT_ROOT/sys"
sudo mount --make-rslave "$_REMOUNT_ROOT/sys"
sudo mount --rbind /tmp "$_REMOUNT_ROOT/tmp"

sudo chroot "$_REMOUNT_ROOT" /bin/bash

echo -e "${GREEN}Remember to execute 'env-update && source /etc/profile' if success${NC}"
