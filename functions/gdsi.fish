# TODO:
# use correct layout for vertical mode

function gdsi

    set STAGED_FILES (git diff --name-only --staged --diff-filter=AM | sk --ansi -i --delimiter=' ' --preview="git diff --staged --color=always "{}" | delta" --preview-window right:60%)
    echo $STAGED_FILES

    git diff --staged --color=always $STAGED_FILES | delta

end
