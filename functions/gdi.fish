# interactively search in git logs for two commits to diff
function gdi

    # use sk to interactively search the git logs and then parse the hash of the chosen commits
    set COMMIT_ONE (sk --ansi -i -c 'git log --oneline' --delimiter=' ' | awk -F' ' '{print $1}')
    set COMMIT_TWO (sk --ansi -i -c 'git log --oneline' --delimiter=' ' | awk -F' ' '{print $1}')


    # call git diff on these two commits now
    if set -q COMMIT_ONE; and set -q COMMIT_TWO
        git diff $COMMIT_ONE $COMMIT_TWO
    end

end
