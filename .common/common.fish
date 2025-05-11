if not functions -q fisher && status is-interactive
    curl -sL https://git.io/fisher | source; and fisher install jorgebucaran/fisher
    # some fish plugin require install ghcup, openssh-server, sdkman, nvm
    isatty; and set_color yellow
    echo automatically installed fisher
    isatty; and set_color normal
end

# add the given path into specified fish variables
# return 0 on success, 1 on path not exist/invalid path, 2 on path already added, 3 others
function fish_path_add
    # TODO: use the fish command `fish_add_path`
    set -l cnt (count $argv 2> /dev/null)
    if test $cnt -ne 2
        isatty; and set_color red
        echo -e usage: $_ \$fish_variable \$path
        isatty; and set_color normal
        return 3
    end

    set -l fish_variable $argv[1]
    set -l pth $argv[2]
    if ! test -d $pth
        isatty; and set_color red
        echo -e \'$pth\' not a existing path
        isatty; and set_color normal
        return 1
    else
        set -l pth (realpath -s $pth)
        if fish -c "contains -- $pth \$$fish_variable"
            isatty; and set_color yellow
            echo -e $pth already added in $fish_variable
            isatty; and set_color normal
            return 2
        else
            fish -c "set -U $fish_variable \$$fish_variable '$pth'"
            isatty; and set_color green
            echo -e added $pth to $fish_variable
            isatty; and set_color normal
            return 0
        end
    end
end

# remove path from fish variables
# return 0 on success, 1 if path not exist/invalid, 3 others
function fish_path_rm
    set -l cnt (count $argv 2> /dev/null)
    if test $cnt -ne 2
        isatty; and set_color red
        echo -e usage: $_ \$fish_variable \$path
        isatty; and set_color normal
        return 3
    end

    set -l fish_variable $argv[1]
    set -l pth (realpath -s $argv[2] 2> /dev/null); or set -l pth $argv[2]

    set -l index (fish -c "contains -i '$pth' \$$fish_variable; or echo 0")
    if test $index -gt 0
        set -l path_removing "$fish_variable"[$index]
        fish -c "set -e -U $path_removing"
        isatty; and set_color green
        echo -e removed $pth from $fish_variable
        isatty; and set_color normal
        return 0
    else
        isatty; and set_color red
        echo -e \'$pth\' not found in $fish_variable
        isatty; and set_color normal
        return 1
    end
end

function fish_user_paths_add
    for ph in $argv
        fish_path_add fish_user_paths $ph; or return $status
    end
end

function fish_user_paths_rm
    for ph in $argv
        fish_path_rm fish_user_paths $ph; or return $status
    end
end

function fish_complete_path_add
    for ph in $argv
        fish_path_add fish_complete_path $ph; or return $status
    end
end

function fish_complete_path_rm
    for ph in $argv
        fish_path_rm fish_complete_path $ph; or return $status
    end
end

function addcompaths
    function addcompath
        if count $argv >/dev/null
            if ! test -d $argv[1]
                set_color red
                echo -e \'$argv[1]\' not a existing path
                set_color normal
            else
                set -l pth (realpath -s $argv[1])
                if contains -- $pth $fish_complete_path
                    set_color yellow
                    echo -e $pth already added
                    set_color normal
                else
                    set -U fish_complete_path $fish_complete_path $pth
                    set_color green
                    echo -e added $pth to fish_complete_path
                    set_color normal
                end
            end
        end
    end

    for ph in $argv
        addcompath $ph
    end
end

if type -qf lsd
    # use https://github.com/Peltoche/lsd as alternative to ls
    function ls -w lsd -d "lsd as ls"
        command lsd $argv
    end
else if type -qf exa
    # or use https://github.com/ogham/exa
    function ls -w exa -d "exa as ls"
        command exa --icons $argv
    end
end

if type -qf zoxide
    zoxide init fish | source
end

if type -qf fff
    function f
        fff $argv
        set -q XDG_CACHE_HOME; or set XDG_CACHE_HOME $HOME/.cache
        cd (cat $XDG_CACHE_HOME/fff/.fff_d)
    end
end

if type -qf tmux
    function tmux -w tmux -d "tmux wrapper to let italic available"
        command env TERM=screen-256color tmux $argv
    end
end

function rm -w rm -d "rm with -v"
    command rm -v $argv
end

if type -qf pyenv
    pyenv init - | source
end

if test -e $HOME/.nix-profile/etc/profile.d/nix.fish
    source $HOME/.nix-profile/etc/profile.d/nix.fish
end

if type -qf kubectl
    kubectl completion fish | source
end

set -x GPG_TTY (tty)

# vi key bindings but also <c-a>/<c-f> etc
fish_hybrid_key_bindings
