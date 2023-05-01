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

Excluded are paths or hooks which do not directly modify the behavior of the shell.

## Config

### Path and Hooks

```fish
set -gx fish_user_paths $(/opt/homebrew/bin/brew --prefix python)/libexec/bin /Users/rishab/go/bin /Users/rishab/.asdf/shims /opt/homebrew/opt/asdf/libexec/bin /opt/homebrew/sbin /Users/rishab/.emacs.d/bin /Users/rishab/.local/bin /Users/rishab/.cargo/bin '/Applications/Visual Studio Code.app/Contents/Resources/app/bin' /opt/homebrew/bin /opt/homebrew/opt/fzf/bin /opt/homebrew/opt/llvm/bin

starship init fish | source
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

zoxide init fish | source

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

alias yadmui="yadm enter lazygit"

function reload
  crtangle ~/.config/fish/README.md
  source ~/.config/fish/config.fish
end

alias trash='trash -F'

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
