# This is a variation of the actual `ff` function. 
# It's purpose is the search directely in my wiki directory
#
# search in files with rg
# select and/or refine search with skim
# preview results with bat
# open selected result at line x in nvim
function fw

    # first, decide if the preview window should be at the top or on the side
    set DIRECTION right
    # get the width of the terminal
    if test (tput cols) -lt 110
        set DIRECTION up
    end

    # this results in a result like "lua/init.lua +12", but nvim interprets it as two filenames
    set SEARCH_RESULT (sk --ansi -i -c 'rg --line-number --pretty --ignore-case "{}" ~/wiki' --delimiter=':' --preview 'bat {1} --color=always --line-range=:500 --decorations=always --highlight-line={2} --theme=base16' --preview-window position:$DIRECTION +{2}-/2 | awk -F':' '{print $1" +"$2}')
    # this results in two arguments:
    #   - [1]:= filepath
    #   - [2]:= line number
    set SPLIT_RESULT (string split " " $SEARCH_RESULT)
    # now nvim can use both arguments as intended

    if set -q SPLIT_RESULT[1] # ... but only if filename is not empty
        nvim $SPLIT_RESULT[1] $SPLIT_RESULT[2]
    end
end
