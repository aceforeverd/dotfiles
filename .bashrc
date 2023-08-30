if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
if [[ -n "$SSH_CONNECTION" ]] ; then
    export PINENTRY_USER_DATA="USER_CURSES=1"
fi

if [ -r "$HOME/.dotfiles/.common/common.bash" ] ; then
    . "$HOME/.dotfiles/.common/common.bash"

    # add_env_path
fi


PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\$\[\033[00m\] '

for sh in "$HOME"/.config/bash_completion.d/*.bash ; do
    [ -r "$sh" ] && . "$sh"
done

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

if command -v zoxide > /dev/null ; then
    eval "$(zoxide init bash)"
fi
