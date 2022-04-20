if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export GPG_TTY=$(tty)
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
