# TODO: 
# make output monitor conform

# this function spawns a fuzzy finder for custom commands.
function gg


    function print_commands

        # the input for sk/fzf needs to be specified like this:
        # 'description'  'Advanced description'  'actual command'
        #
        # "$(echo ...)" is neccessary for multiline strings (note the quotes!)
        set GIT_TWO_DIFF (printf "%s  %s  %s" "diff two commits, select interactively (gdi)" "$(echo '# interactive git diff selector for commits\nspawns two promts to select the commits.\nnote:The diff is shown such that the first selected commit is the newer state.')" "gdi")
        set GIT_STAGE_DIFF (printf "%s  %s  %s" "show the diff for the currently staged files (gdsi)" "$(echo '# staged files diff view\nShows all the already staged changes before a commit.')" "gdsi")
        set CMDS $GIT_TWO_DIFF $GIT_STAGE_DIFF

        for cmd in $CMDS
            echo $cmd
        end
    end

    # echo -e is important to make glow respect the linebreaks
    # | fish is neccessary to execuate the custom functions
    # --with-nth=1 only shows (and searches) the short description for the fuzzy finder
    print_commands | sk --delimiter='  ' --with-nth=1 --preview="echo -e {2} | glow --style=dark -w 80" | awk -F'  ' '{print $3}' | fish


end
