if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!  return
fi

alias dbcli="dropbox-cli"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]] ; then
    export PINENTRY_USER_DATA="USER_CURSES=1"
fi

export COMPOSER_HOME="$HOME/.composer"
export GOPATH=$HOME/.go
GEM_PATH=$HOME/.gem/ruby/2.6.0
CARGO_HOME=$HOME/.cargo
YARN_HOME=$HOME/.config/yarn
export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale
export JAVA_OPTS="-Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=8118"
export TERMINFO=/etc/terminfo
export NVIM_PYTHON_LOG_FILE=/home/ace/nvim-python.log

if [ -r "$HOME/.common/common.bash" ] ; then
    . "$HOME/.common/common.bash"

    add_env_path \
        "$CARGO_HOME/bin" \
        "$GOPATH/bin" \
        "$GEM_PATH/bin" \
        "$YARN_HOME/bin" \
        "$HOME/.local/bin" \
        "$HOME/.luarocks/bin" \
        "$HOME/.dart-sdk/bin" \
        "$HOME/.pub-cache/bin" \
        "$COMPOSER_HOME/vendor/bin" \
        /mnt/extra/android-sdk/platform-tools \
        /mnt/extra/android-sdk/tools/bin \
        /mnt/extra/android-sdk/tools
fi


PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W\$\[\033[00m\] '

for sh in $HOME/.config/bash_completion.d/*.bash ; do
    [ -r "$sh" ] && . "$sh"
done

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# go get -u github.com/posener/complete/gocomplete
complete -C $HOME/.go/bin/gocomplete go

COMPOSER_COMPLETE="$HOME/.composer/vendor/stecman/composer-bash-completion-plugin/hooks/bash-completion"
[ -r "$COMPOSER_COMPLETE" ] && . "$COMPOSER_COMPLETE"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.bash.inc' ]; then source '/opt/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.bash.inc' ]; then source '/opt/google-cloud-sdk/completion.bash.inc'; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/ace/.sdkman"
[[ -s "/home/ace/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ace/.sdkman/bin/sdkman-init.sh"
