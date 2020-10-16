if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# see https://superuser.com/questions/776008/how-to-remove-a-path-from-path-variable-in-fish
if not functions -q addpaths
    function addpaths
        function addpath
            if count $argv > /dev/null
                if ! test -d $argv[1]
                    set_color red; echo -e \'$argv[1]\' not a existing path; set_color normal
                else
                    set -l pth (realpath $argv[1])
                    contains -- $pth $fish_user_paths
                    or set -U fish_user_paths $fish_user_paths $pth
                end
            end
        end

        for ph in $argv
            addpath $ph
        end

        echo "Updated PATH: $PATH"
    end

    funcsave addpaths
end

if not functions -q removepaths
    function removepaths
        function removepath
            set -l pth (realpath $argv[1])
            if set -l index (contains -i $pth $fish_user_paths)
                set --erase --universal fish_user_paths[$index]
            else
                set_color red; echo -e \'$pth\' not found in fish_user_paths: $fish_user_paths; set_color normal
            end
        end

        for ph in $argv
            removepath $ph
        end
        echo "Updated PATH: $PATH"
    end

    funcsave removepaths
end

set -x GPG_TTY (tty)
