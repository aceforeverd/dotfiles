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

    # must use "$fish_variable"[$index] in set -e, others seems not work
    fish -c "
    if set -l index (contains -i $pth \$$fish_variable)
        set -e -U "$fish_variable"[$index]
        set_color green; echo -e removed $pth from $fish_variable; set_color normal
    else
        set_color red; echo -e \'$pth\' not found in $fish_variable: \$$fish_variable; set_color normal
    end
    "
end

# see https://superuser.com/questions/776008/how-to-remove-a-path-from-path-variable-in-fish
if not functions -q addpaths
    function addpaths
        function addpath
            if count $argv > /dev/null
                if ! test -d $argv[1]
                    set_color red; echo -e \'$argv[1]\' not a existing path; set_color normal
                else
                    set -l pth (realpath -s $argv[1])
                    if contains -- $pth $fish_user_paths
                        set_color yellow; echo -e $pth already added; set_color normal
                    else
                        set -U fish_user_paths $fish_user_paths $pth
                        set_color green; echo -e added $pth to fish_user_paths; set_color normal
                    end
                end
            end
        end

        for ph in $argv
            addpath $ph
        end
    end

    funcsave addpaths
end

if not functions -q removepaths
    function removepaths
        function removepath
            set -l pth (realpath -s $argv[1] 2> /dev/null); or set -l pth $argv[1]

            if set -l index (contains -i $pth $fish_user_paths)
                set --erase --universal fish_user_paths[$index]
                set_color green; echo -e removed $pth from fish_user_paths; set_color normal
            else
                set_color red; echo -e \'$pth\' not found in fish_user_paths: $fish_user_paths; set_color normal
            end
        end

        for ph in $argv
            removepath $ph
        end
    end

    funcsave removepaths
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
