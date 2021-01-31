if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

function fish_path_add
    set -l cnt (count $argv 2> /dev/null)
    if test $cnt -ne 2
        set_color red; echo -e usage: $_ \$fish_variable \$path; set_color normal
        return
    end

    set -l fish_variable $argv[1]
    set -l pth $argv[2]
    if ! test -d $pth
        set_color red; echo -e \'$pth\' not a existing path; set_color normal
    else
        set -l pth (realpath -s $pth)
        fish -c """
        if contains -- $pth \$$fish_variable
            set_color yellow; echo -e $pth already added; set_color normal
        else
            set -U $fish_variable \$$fish_variable $pth
            set_color green; echo -e added $pth to $fish_variable; set_color normal
        end
        """
    end
end

function fish_path_rm
    set -l cnt (count $argv 2> /dev/null)
    if test $cnt -ne 2
        set_color red; echo -e usage: $_ \$fish_variable \$path; set_color normal
        return
    end

    set -l fish_variable $argv[1]
    set -l pth (realpath -s $argv[2] 2> /dev/null); or set -l pth $argv[2]


    set -l index (fish -c "contains -i $pth \$$fish_variable; or echo 0")
    if test $index -gt 0
        set -l path_removing "$fish_variable"[$index]
        fish -c "set -e -U $path_removing"
        set_color green; echo -e removed $pth from $fish_variable; set_color normal
    else
        set_color red; echo -e \'$pth\' not found in $fish_variable; set_color normal
    end
end

if not functions -q fish_user_paths_add
    function fish_user_paths_add
        for ph in $argv
            fish_path_add fish_user_paths $ph
        end
    end

    funcsave fish_user_paths_add
end

if not functions -q fish_user_paths_rm
    function fish_user_paths_rm
        for ph in $argv
            fish_path_rm fish_user_paths $ph
        end
    end

    funcsave fish_user_paths_rm
end

if not functions -q fish_complete_path_add
    function fish_complete_path_add
        for ph in $argv
            fish_path_add fish_complete_path $ph
        end
    end

    funcsave fish_complete_path_add
end

if not functions -q fish_complete_path_rm
    function fish_complete_path_rm
        for ph in $argv
            fish_path_rm fish_complete_path $ph
        end
    end

    funcsave fish_complete_path_rm
end

set -x GPG_TTY (tty)
