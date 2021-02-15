if not functions -q fisher && status is-interactive
    curl -sL https://git.io/fisher | source; and fisher install jorgebucaran/fisher
    isatty stdout; and set_color yellow
    echo automatically installed fisher
    isatty stdout; and set_color normal
end

# add the given path into specified fish variables
# return 0 on success, 1 on path not exist/invalid path, 2 on path already added, 3 others
function fish_path_add
    set -l cnt (count $argv 2> /dev/null)
    if test $cnt -ne 2
        isatty stdout; and set_color red
        echo -e usage: $_ \$fish_variable \$path
        isatty stdout; and set_color normal
        return 3
    end

    set -l fish_variable $argv[1]
    set -l pth $argv[2]
    if ! test -d $pth
        isatty stdout; and set_color red
        echo -e \'$pth\' not a existing path
        isatty stdout; and set_color normal
        return 1
    else
        set -l pth (realpath -s $pth)
        if fish -c "contains -- $pth \$$fish_variable"
            isatty stdout; and set_color yellow
            echo -e $pth already added in $fish_variable
            isatty stdout; and set_color normal
            return 2
        else
            fish -c "set -U $fish_variable \$$fish_variable $pth"
            isatty stdout; and set_color green
            echo -e added $pth to $fish_variable
            isatty stdout; and set_color normal
        end
    end
end

# remove path from fish variables
# return 0 on success, 1 if path not exist/invalid, 3 others
function fish_path_rm
    set -l cnt (count $argv 2> /dev/null)
    if test $cnt -ne 2
        isatty stdout; and set_color red
        echo -e usage: $_ \$fish_variable \$path
        isatty stdout; and set_color normal
        return 3
    end

    set -l fish_variable $argv[1]
    set -l pth (realpath -s $argv[2] 2> /dev/null); or set -l pth $argv[2]

    set -l index (fish -c "contains -i $pth \$$fish_variable; or echo 0")
    if test $index -gt 0
        set -l path_removing "$fish_variable"[$index]
        fish -c "set -e -U $path_removing"
        isatty stdout; and set_color green
        echo -e removed $pth from $fish_variable
        isatty stdout; and set_color normal
    else
        isatty stdout; and set_color red
        echo -e \'$pth\' not found in $fish_variable
        isatty stdout; and set_color normal
        return 1
    end
end

if not functions -q fish_user_paths_add
    function fish_user_paths_add
        for ph in $argv
            fish_path_add fish_user_paths $ph; or return $status
        end
    end

    funcsave fish_user_paths_add
end

if not functions -q fish_user_paths_rm
    function fish_user_paths_rm
        for ph in $argv
            fish_path_rm fish_user_paths $ph; or return $status
        end
    end

    funcsave fish_user_paths_rm
end

if not functions -q fish_complete_path_add
    function fish_complete_path_add
        for ph in $argv
            fish_path_add fish_complete_path $ph; or return $status
        end
    end

    funcsave fish_complete_path_add
end

if not functions -q fish_complete_path_rm
    function fish_complete_path_rm
        for ph in $argv
            fish_path_rm fish_complete_path $ph; or return $status
        end
    end

    funcsave fish_complete_path_rm
end

set -x GPG_TTY (tty)
