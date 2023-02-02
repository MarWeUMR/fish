# TODO:
# add preview for commit content while selecting interactively, if it even helps...
# set better delta options (diff-so-fancy)
# make diff layout monitor dependend

# interactively search in git logs for two commits to diff
function gdi

    # use sk to interactively search the git logs and then parse the hash of the chosen commits
    set COMMIT_ONE (git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches | sk --ansi -i)
    set COMMIT_TWO (git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches | sk --ansi -i)

    # perform checks 
    if test -z "$COMMIT_ONE"
        echo Arg 1 empty
        return
    end

    if test -z "$COMMIT_TWO"
        echo Arg 2 empty
        return
    end


    set COMMIT_ONE_SPLIT (string split " - " $COMMIT_ONE)
    set COMMIT_TWO_SPLIT (string split " - " $COMMIT_TWO)

    set GIT_DIFF_ARG_ONE (string split " " $COMMIT_ONE_SPLIT[1])
    set GIT_DIFF_ARG_TWO (string split " " $COMMIT_TWO_SPLIT[1])

    if test (string length $GIT_DIFF_ARG_ONE[-1]) -gt 6; and test (string length $GIT_DIFF_ARG_TWO[-1]) -gt 6
        git diff $GIT_DIFF_ARG_TWO[-1] $GIT_DIFF_ARG_ONE[-1]
    else
        echo Something is wrong with the commit hashes
    end

end
