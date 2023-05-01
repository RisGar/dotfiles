---
tangle: /Users/rishab/.config/fish/config.fish
---

# Fish config

My configuration for the fish shell, which I use as my user shell on my MacBook.

## Sources

- [DistroTube's fish config](https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/fish/config.fish)

## Requirements

### Core Packages

Without these, using the config will throw errors, as environment variables will not function correctly or basic commands will not work.

- [fish-shell/fish-shell](https://github.com/fish-shell/fish-shell)
- [neovim/neovim](https://github.com/neovim/neovim): Default editor ([see my config](../nvim/README.md))

- [ogham/exa](https://github.com/ogham/exa): `ls` replacement
- [ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide): `cd` replacement
- [sharkdp/bat](https://github.com/sharkdp/bat): `cat` replacement

- [starship/starship](https://github.com/starship/starship): custom prompt ([see my config](../starship/README.md))

- [Homebrew/brew](https://github.com/Homebrew/brew): Technically not required, but some paths are hard-coded to their `brew` directories
- [brew gcc](https://formulae.brew.sh/formula/gcc): Replaces default C(++) compiler to support newer versions of C++

- [Any Nerd Font](https://www.nerdfonts.com/): Required to display icons correctly

### Additional Packages

Additional functions for the fish shell.
While technically not required, these are all recommended to install in order for this config to work properly without removing some lines of code.

- [RisGar/crtangle](https://github.com/RisGar/crtangle): tangles this (and other) Markdown file(s) to their respective config files. Necessary if you want to edit configs through `README.md` files

- [PatrickF1/fzf.fish](https://github.com/PatrickF1/fzf.fish): search through fish's history and find files directly inside of the shell. Requires some additional dependences, which are by themselves useful tools to search through your files:
  - [junegunn/fzf](https://github.com/junegunn/fzf): main `fzf` client
  - [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep): `grep` replacement
  - [sharkdp/fd](https://github.com/sharkdp/fd): `find` replacement

- [gokcehan/lf](https://github.com/gokcehan/lf): terminal file manager ([see my config](../lf/README.md))
- [TheLocehiliosan/yadm](https://github.com/TheLocehiliosan/yadm): dotfiles manager
- [LinusDierheimer/fastfetch: Like neofetch, but much faster because written in C.](https://github.com/LinusDierheimer/fastfetch)

## Config

### Path and Hooks

```fish
set -gx fish_user_paths $(/opt/homebrew/bin/brew --prefix python)/libexec/bin /Users/rishab/go/bin /Users/rishab/.asdf/shims /opt/homebrew/opt/asdf/libexec/bin /opt/homebrew/sbin /Users/rishab/.emacs.d/bin /Users/rishab/.local/bin /Users/rishab/.cargo/bin '/Applications/Visual Studio Code.app/Contents/Resources/app/bin' /opt/homebrew/bin /opt/homebrew/opt/fzf/bin /opt/homebrew/opt/llvm/bin

zoxide init fish | source
starship init fish | source
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

source /opt/homebrew/opt/asdf/libexec/asdf.fish
source ~/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true
```

### Environment Variables

```fish
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx GPG_TTY (tty)
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx PAGER "less -r"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx BAT_THEME "OneHalfDark"
set -gx CC "/opt/homebrew/bin/gcc-12"
set -gx CXX "/opt/homebrew/bin/g++-12"
```

### Aliases

Aliases and functions to shorten or modify often-used commands.

```fish
alias ls='exa -a --color=always --group-directories-first --icons'
alias la='exa -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='exa -al --color=always --group-directories-first --icons' # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing

alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

alias cd="z"
alias ..='z ..'

function fd
  command fd $argv -X bat
end

# alias config='git --git-dir=$HOME/Documents/Programming/dotfiles --work-tree=$HOME'
# alias configui='lazygit --git-dir=$HOME/Documents/Programming/dotfiles --work-tree=$HOME'
alias yadmui="yadm enter lazygit"

function reload
  crtangle ~/.config/fish/README.md
  source ~/.config/fish/config.fish
end

alias brewfile='brew bundle --global -fv'

alias spotify-dlp="yt-dlp --config-locations ~/.config/yt-dlp/config-spotify"

alias vim='nvim'
alias lxr='iex -S mix'

alias gcc='gcc-12'
alias g++="g++-12"
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

### Keybinds

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
