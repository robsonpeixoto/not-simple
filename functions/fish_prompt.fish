# Simple
# https://github.com/sotayamashita/simple
#
# MIT © Sota Yamashita

function __print_color
    set -l color  $argv[1]
    set -l string $argv[2]

    set_color $color
    printf $string
    set_color normal
end

function fish_prompt -d "Simple Fish Prompt"
    echo -e ""

    # Current working directory
    #
    #set -l pwd_glyph " in "
    set -l pwd_string (echo $PWD | sed 's|^'$HOME'\(.*\)$|~\1|')

    __print_color ffffff "$pwd_glyph"
    __print_color 5DAE8B "$pwd_string"


    # Git
    #
    if git_is_repo
        set -l branch_name (git_branch_name)
        set -l git_glyph " git:("
        set -l git_branch_glyph

        __print_color ffffff "$git_glyph"
        __print_color 6597ca "$branch_name"

        if git_is_touched
            if git_is_staged
                if git_is_dirty
                    set git_branch_glyph " [±]"
                else
                    set git_branch_glyph " [+]"
                end
            else
                set git_branch_glyph " [?]"
            end
        end

        __print_color 6597ca "$git_branch_glyph"
        __print_color ffffff ")"
    end

    if test -n "$VIRTUAL_ENV"
        __print_color ffffff " py:("
        __print_color FFD647 (basename $VIRTUAL_ENV)
        __print_color ffffff ")"
    end

    set -l ruby_version (fry current)
    if [ "$ruby_version" != "system" ]
        __print_color ffffff " rb:("
        __print_color E61622 $ruby_version
        __print_color ffffff ")"
    end

    if test -n "$N_VERSION"
        __print_color ffffff " js:("
        __print_color 83CD29 $N_VERSION
        __print_color ffffff ")"
    end

    __print_color FF7676 "\n❯ "
end
