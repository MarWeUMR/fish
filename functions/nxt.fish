function nxt



    # this results in a result like "lua/init.lua +12", but nvim interprets it as two filenames
    set SELECTED_TEST (cargo nextest list --all-features | fzf --ansi -i | awk '{$1=$1};1')

    echo $SELECTED_TEST
    # now nvim can use both arguments as intended ...
    if set -q SELECTED_TEST
        cargo nextest run --all-features $SELECTED_TEST --no-capture
    end

end
