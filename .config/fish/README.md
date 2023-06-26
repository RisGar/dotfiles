---
tangle: /Users/rishab/.config/fish/config.fish
---

# Fish config

My configuration for the fish shell on macOS.

## Sources

- [DistroTube's fish config](https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/fish/config.fish)

## Dependencies

- [fish-shell/fish-shell](https://github.com/fish-shell/fish-shell)
- [starship/starship](https://github.com/starship/starship): custom prompt ([see my config](../starship/README.md))
- [neovim/neovim](https://github.com/neovim/neovim): Default editor ([see my config](../nvim/README.md))
- [ogham/exa](https://github.com/ogham/exa): `ls` replacement
- [ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide): `cd` replacement
- [sharkdp/bat](https://github.com/sharkdp/bat): `cat` replacement
- [RisGar/crtangle](https://github.com/RisGar/crtangle): tangles this (and other) Markdown file(s) to their respective config files.
- [brew gcc](https://formulae.brew.sh/formula/gcc): Replaces default C(++) compiler to support newer versions of C++
- [Any Nerd Font](https://www.nerdfonts.com/): Required to display icons correctly
- [gokcehan/lf](https://github.com/gokcehan/lf): terminal file manager ([see my config](../lf/README.md))
- [TheLocehiliosan/yadm](https://github.com/TheLocehiliosan/yadm): dotfiles manager
- [LinusDierheimer/fastfetch](https://github.com/LinusDierheimer/fastfetch)
- [PatrickF1/fzf.fish](https://github.com/PatrickF1/fzf.fish): Search through fish's history and find files directly inside of the shell.
- [junegunn/fzf](https://github.com/junegunn/fzf): main `fzf` client
- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep): `grep` replacement
- [sharkdp/fd](https://github.com/sharkdp/fd): `find` replacement
- [ali-rantakari/trash](https://github.com/ali-rantakari/trash): cli to move into `~/.Trash` with additional features
- [yt-dlp/yt-dlp](https://github.com/yt-dlp/yt-dlp): `youtube-dl` fork with additional features

Excluded from this list are paths or hooks which do not directly modify the behavior of the shell.

## Config

### Variables and Hooks

```fish
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_CACHE_HOME "$HOME/.cache"

set -gx fish_user_paths /opt/homebrew/opt/llvm/bin $(/opt/homebrew/bin/brew --prefix python)/libexec/bin "$XDG_DATA_HOME/go/bin" /Users/rishab/.local/share/asdf/shims /opt/homebrew/opt/asdf/libexec/bin /opt/homebrew/sbin /Users/rishab/.emacs.d/bin /Users/rishab/.local/bin /Users/rishab/.cargo/bin '/Applications/Visual Studio Code.app/Contents/Resources/app/bin' /opt/homebrew/bin /opt/homebrew/opt/fzf/bin

starship init fish | source
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

zoxide init fish | source

source /opt/homebrew/opt/asdf/libexec/asdf.fish

source "$XDG_DATA_HOME/opam/opam-init/init.fish" > /dev/null 2> /dev/null; or true

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx PAGER "less -r"
set -gx BAT_THEME "OneHalfDark"
set -gx CC "/opt/homebrew/opt/llvm/bin/clang"
set -gx CXX "/opt/homebrew/opt/llvm/bin/clang++"

set -gx HOMEBREW_BUNDLE_MAS_SKIP

set -gx GEM_HOME "$XDG_DATA_HOME/gem"
set -gx OPAMROOT "$XDG_DATA_HOME/opam"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx GVIMINIT 'let $MYGVIMRC = !has("nvim") ? "$XDG_CONFIG_HOME/vim/gvimrc" : "$XDG_CONFIG_HOME/nvim/init.gvim" | so $MYGVIMRC'
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -gx LESSHISTFILE "$XDG_CACHE_HOME/less/history"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx CABAL_CONFIG "$XDG_CONFIG_HOME/cabal/config"
set -gx CABAL_DIR "$XDG_DATA_HOME/cabal"
set -gx ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"
set -gx KAGGLE_CONFIG_DIR "$XDG_CONFIG_HOME/kaggle"
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
```

### Aliases

Aliases and functions to shorten or modify often-used commands.

```fish
alias ls='exa -aF1 --color=always --group-directories-first --icons'
alias la='exa -aF --color=always --group-directories-first --icons' # all files and dirs
alias ll='exa -alF --color=always --group-directories-first --icons' # long format
alias lt='exa -aTF --color=always --group-directories-first --icons' # tree listing

alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias cd="z"
alias ..='z ..'

function fd
  command fd $argv -X bat
end

alias yadmui="yadm enter lazygit"

function reload
  crtangle ~/.config/fish/README.md
  source ~/.config/fish/config.fish
end

alias trash='trash -F'

alias brewfile='brew bundle --global -fv'

alias spotify-dlp="yt-dlp --config-locations ~/.config/yt-dlp/config-spotify"

alias vim="nvim"

alias gcc="gcc-13"
alias g++="g++-13"
```

### Extensions & Software

#### fzf

```fish
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse'

set fzf_preview_dir_cmd exa --all --color=always
set fzf_fd_opts --hidden --exclude=.git
fzf_configure_bindings --directory=\cf
```

#### lf file manager

```fish
function lf -d "Launch lf file manager with exit dir cd support"
  set tmp (mktemp)
  command lf -last-dir-path=$tmp $argv

  if test -f $tmp
    set dir (cat $tmp)
    if test -n $dir -a -d $dir
      builtin cd -- $dir
    end
  end

  command rm -f -- $tmp
end
```

### gnupg

```fish
set -gx GPG_TTY (tty)
gpgconf --launch gpg-agent
```

### Keybindings

Configuration for fish to work with vi-style bindings.

```fish
function fish_user_key_bindings
  fish_vi_key_bindings insert
end

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

bind -M visual -m default y "fish_clipboard_copy; commandline -f end-selection repaint-mode"
bind p forward-char "commandline -i ( pbpaste; echo )[1]" # TODO
```

### Appearance

```fish
set TERM xterm-256color

function fish_greeting
  fastfetch
end

if status is-interactive
  set -l onedark_options -b

  if set -q VIM # from (neo)vim
    set onedark_options -256
  end

  set_onedark $onedark_options
end
```
