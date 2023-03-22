if status is-interactive
    # Commands to run in interactive sessions can go here

    fish_add_path ~/.cargo/bin
    fish_add_path ~/.juliaup/bin
    fish_add_path ~/julia-1.8.5/bin
    fish_add_path /usr/local/bin

    starship init fish | source
    zoxide init fish | source
    pyenv init - | source
    mcfly init fish | source

    status --is-interactive; and pyenv virtualenv-init - | source


    set -gx MCFLY_KEY_SCHEME vim
    set -gx MCFLY_FUZZY 2
    set -gx MCFLY_RESULTS 50

    set -gx EDITOR nvim
    set --universal nvm_default_version lts
    set -xg PYTHONPATH ~/.pyenv/versions/venv3916/bin $PYTHONPATH

    set -xg FORGIT_COPY_CMD xclip -selection clipboard

    alias ls="exa --tree --level=1 --icons"
    alias ls2="exa --tree --level=2 --icons"
    alias clpy="cargo fmt & cargo clippy --all-targets --all-features  -- -D warnings -D clippy::derivable-impls"

    alias nd='docker run -w /home/ubuntu/workspace -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v "$PWD:/home/ubuntu/workspace" -v "/home/ubuntu/programming/docker/nvchad/nvchad_config:/home/ubuntu/.config/nvim/lua/custom" -it --rm nvchad:latest'

    set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow -l --glob "!.git/*" .'


    # alias ff = "grep --recursive --line-number --binary-files=without-match . | fzf --delimiter=':' -n 2.. --preview-window '+{2}-/2'  --preview 'bat {1} --color=always --line-range=:500 --decorations=always --highlight-line={2}'"
    # alias ff="sk --ansi  --preview="bat --color=always {}" -c 'rg --color=always -l "{}"'"
    #alias for pyenv venv activation
    alias act-venv="source ~/.pyenv/versions/venv3916/bin/activate.fish"
end
