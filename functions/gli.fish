# TODO:
# interactively search through last commits
function gli

    set PREVIEW_CMD (printf "git diff %s^! | delta --diff-so-fancy --line-numbers --side-by-side --width=$(tput cols)" {2})
    set DIRECTION up
    set WIDTH 180
    if test (tput cols) -lt 110
        set DIRECTION up
        set WIDTH 80
        set PREVIEW_CMD (printf "git diff %s^! | delta --diff-so-fancy --line-numbers" {2})
    end

    set COMMIT (git log --color --graph --pretty=format:'%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset - %Cred%h%Creset ' --abbrev-commit --branches | fzf --ansi --delimiter=' - ' -i --preview=$PREVIEW_CMD --preview-window=$DIRECTION,70%)
    set SPLIT (string split " - " $COMMIT)

    echo $SPLIT[2]

end
