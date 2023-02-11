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
        set GIT_STAGE_DIFF_ALL (printf "%s  %s  %s" "show the diff for the staging area (gdsi_all)" "$(echo '# staging area diff view\nShows all the already staged changes before a commit.')" "gdsi_all")
        set GIT_LIST_COMMITS (printf "%s  %s  %s" "show all commits (gli)" "$(echo '# commit view\nShows all commits.')" "gli")
        set GIT_COMPARE_MAIN (printf "%s  %s  %s" "show the diff of current HEAD to upstream/main" "$(echo '# diff view\nShows the current changes in contrast to the lastest state of the main branch.')" "git diff upstream/main..HEAD | delta --side-by-side --diff-so-fancy")
        set GIT_COMPARE_MAIN_INTERACTIVE (printf "%s  %s  %s" "show the diff of current HEAD to upstream/main (per file)" "$(echo '# diff view\nShows the current changes in contrast to the lastest state of the main branch. \nSingle file version.')" "gdmi")
        set CARGO_NEXTEST (printf "%s  %s  %s" "show a list of cargo tests (nxt)" "$(echo '# Cargo Tests\nShows the available cargo tests.')" "nxt")
        set CMDS $GIT_TWO_DIFF $GIT_STAGE_DIFF $GIT_STAGE_DIFF_ALL $GIT_LIST_COMMITS $GIT_COMPARE_MAIN $GIT_COMPARE_MAIN_INTERACTIVE $CARGO_NEXTEST

        for cmd in $CMDS
            echo $cmd
        end
    end

    # echo -e is important to make glow respect the linebreaks
    # | fish is neccessary to execuate the custom functions
    # --with-nth=1 only shows (and searches) the short description for the fuzzy finder
    print_commands | sk --delimiter='  ' --with-nth=1 --preview="echo -e {2} | glow --style=dark -w 80" | awk -F'  ' '{print $3}' | fish


end
