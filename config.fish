if status is-interactive
    # Commands to run in interactive sessions can go here
	fish_add_path ~/.cargo/bin
	fish_add_path ~/.local/share/nvm/v17.8.0/bin
	fish_add_path ~/.local/bin
	fish_add_path /usr/local/lib
  starship init fish | source
  zoxide init fish | source
  
  set -Ux LIBCLANG_PATH "/usr/lib"
  set -gx EDITOR nvim

  alias ls="exa --tree --level=1 --icons"
  alias ls2="exa --tree --level=2 --icons"
  abbr -a -g lf lfcd

  end
