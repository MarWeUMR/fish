# this function lists the staged files with their diffs.
function gdsi

    set DIRECTION right
    set PREVIEW_CMD "git diff --staged --color=always "{}" | delta --diff-so-fancy --line-numbers --side-by-side --width=190"

    # get the width of the terminal
    if test (tput cols) -lt 110
        set DIRECTION up
        set PREVIEW_CMD "git diff --staged --color=always "{}" | delta --diff-so-fancy --line-numbers"

    end

    set STAGED_FILES (git diff --name-only --staged --color-moved --diff-filter=AM | sk --ansi -i --delimiter=' ' --preview=$PREVIEW_CMD --preview-window position:$DIRECTION:80%)

    if test -z "$STAGED_FILES"
        return
    else
        # get the diff of the selected file with delta and side-by-side view,
        # if the display is wide enough. otherwise use inline variant.
        if test (tput cols) -lt 110 # horizontal view
            git diff --staged --color=always --color-moved $STAGED_FILES | delta --diff-so-fancy
        else # vertical view
            git diff --staged --color=always --color-moved $STAGED_FILES | delta --side-by-side --diff-so-fancy
        end
    end

end
