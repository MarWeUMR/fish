# this method lists all available cargo tests and allows to fuzzy find the test you want to run
# TODO: make multiple test selections possible
function nxt

    # get a list of all tests and format it such that fzf can be used.
    set LIST_OF_TESTS (cargo nextest list --all-features)
    # xargs -n 1 is used to make a fzf compatible list of the items from above
    set SELECTED_TEST (echo $LIST_OF_TESTS | xargs -n 1 | fzf --ansi -i -m)


    if test -z "$SELECTED_TEST"
        return
    else
        cargo nextest run --all-features $SELECTED_TEST --no-capture
        echo cargo nextest run --all-features $SELECTED_TEST --no-capture
    end

end
