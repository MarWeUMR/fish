# this function lists the changed files with respect to the current upstream main branch.
# optional: open file with neovim and set gitsigns base to upstream/main
function gdmi

    # default assumption: main branch
    set BRANCH main
    set MAIN (git ls-remote upstream main)
    if test -z "$MAIN"
        # ok, lets try master branch
        set MAIN (git ls-remote upstream master)
        set BRANCH master
    end

    # some other setup, return without doing anything
    if test -z "$MAIN"
        return
    end

    set DIRECTION up
    set PREVIEW_CMD "git diff --color=always upstream/$BRANCH..HEAD -- "{}" | delta --diff-so-fancy --line-numbers --side-by-side --width=$(tput cols)"

    # get the width of the terminal
    if test (tput cols) -lt 110
        set DIRECTION up
        set PREVIEW_CMD "git diff --color=always upstream/$BRANCH..HEAD -- "{}" | delta --diff-so-fancy --line-numbers"

    end

    set TOGGLE_DELETED "autocmd VimEnter * if exists(':Gitsigns') | Gitsigns toggle_deleted | endif"
    set TOGGLE_LINEHL "autocmd VimEnter * if exists(':Gitsigns') | Gitsigns toggle_linehl | endif"
    set SET_BASE (printf "autocmd VimEnter * if exists(':Gitsigns') | Gitsigns change_base upstream/%s | endif" "$BRANCH")

    # note: https://github.com/junegunn/fzf/issues/1593#issuecomment-498007983
    # the most important part here is the redirection of stdin and stdout for opening neovim from the fzf binding!
    set OPEN_NVIM (echo $(printf 'nvim -c "%s" -c "%s" -c "%s"' "$SET_BASE" "$TOGGLE_LINEHL" "$TOGGLE_DELETED"))
    set SELECTED_FILE (git diff --name-only --color-moved --diff-filter=AM upstream/$BRANCH..HEAD | fzf --ansi -i --delimiter=' ' --preview=$PREVIEW_CMD --preview-window=$DIRECTION,80% --color header:italic --header 'Press CTRL-o to edit with nvim' --bind="ctrl-o:execute($OPEN_NVIM {} < /dev/tty > /dev/tty 2>&1)")

    if test -z "$SELECTED_FILE"
        return
    else
        # get the diff of the selected file with delta and side-by-side view,
        # if the display is wide enough. otherwise use inline variant.
        if test (tput cols) -lt 110 # vertical view
            git diff --color=always --color-moved --color-moved --diff-filter=AM upstream/$BRANCH..HEAD $SELECTED_FILE | delta --diff-so-fancy
        else # horizontal view
            git diff --color=always --color-moved --color-moved --diff-filter=AM upstream/$BRANCH..HEAD $SELECTED_FILE | delta --side-by-side --diff-so-fancy
        end
    end
end
