# this function lists the staged files with their diffs all at once
function gdsi_all

    # get the diff of the staging area with delta and side-by-side view,
    # if the display is wide enough. otherwise use inline variant.
    if test (tput cols) -lt 110 # horizontal view
        git diff --staged --color=always --color-moved | delta --diff-so-fancy
    else # vertical view
        git diff --staged --color=always --color-moved | delta --side-by-side --diff-so-fancy
    end

end
