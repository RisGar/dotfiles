---
tangle: /Users/rishab/.config/fish/config.fish
---

# Fish config

- My configuration for the fish shell.

- All configuration is done inside of `README.md` which is tangled to `config.fish` and `fish_plugins`. The other directories only contain files managed by fisher.

## Sources

- [DistroTube's fish config](https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/fish/config.fish)

## Dependencies

- Optional dependencies are listed under the respective categories

### Required depedencies

- [fish-shell/fish-shell](https://github.com/fish-shell/fish-shell)
- [neovim/neovim](https://github.com/neovim/neovim): Default editor ([see my config](../nvim/README.md))
- [sharkdp/bat](https://github.com/sharkdp/bat): `cat` replacement
- [RisGar/crtangle](https://github.com/RisGar/crtangle): tangles this (and other) Markdown file(s) to their respective config files.
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

## Config

### Variables and Hooks

- Uses the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html) to organise dotfiles.

```fish
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_CACHE_HOME "$HOME/.cache"

set -gx HOMEBREW_PREFIX $(/opt/homebrew/bin/brew --prefix)
set -gx HOMEBREW_OPT $HOMEBREW_PREFIX/opt

set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx PNPM_HOME "$XDG_DATA_HOME/pnpm"

set -gx fish_user_paths "$CARGO_HOME/bin" "$HOMEBREW_PREFIX/opt/llvm/bin" "$HOMEBREW_PREFIX/opt/fzf/bin" $($HOMEBREW_PREFIX/bin/brew --prefix python)/libexec/bin \
"$XDG_DATA_HOME/go/bin" "$HOME/.local/bin" \
"/Applications/Visual Studio Code.app/Contents/Resources/app/bin" "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" \
"$XDG_DATA_HOME/cabal/bin" "$PNPM_HOME" "$XDG_DATA_HOME/npm/bin" "$XDG_DATA_HOME/gem/bin" "$HOME/.iterm2" "$XDG_DATA_HOME/fnm" \
"$HOME/Library/Application Support/Coursier/bin" "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" "$HOMEBREW_OPT/ruby/bin"

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx MANPAGER "nvim +Man!"
# set -gx PAGER "less -r"
set -gx PAGER "ov"
set -gx GIT_PAGER "delta"
set -gx BAT_THEME "OneHalfDark"
set -gx CC "$HOMEBREW_OPT/llvm/bin/clang"
set -gx CXX "$HOMEBREW_OPT/llvm/bin/clang++"

set -gx HOMEBREW_BAT true

set -gx GEM_HOME "$XDG_DATA_HOME/gem"
set -gx OPAMROOT "$XDG_DATA_HOME/opam"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx GVIMINIT "$XDG_CONFIG_HOME/nvim/init.gvim"
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -gx LESSHISTFILE "$XDG_CACHE_HOME/less/history"
set -gx GOPATH "$XDG_DATA_HOME/go"
set -gx CABAL_CONFIG "$XDG_CONFIG_HOME/cabal/config"
set -gx CABAL_DIR "$XDG_DATA_HOME/cabal"
set -gx GHCUP_USE_XDG_DIRS true
set -gx ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"
set -gx KAGGLE_CONFIG_DIR "$XDG_CONFIG_HOME/kaggle"
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx WAKATIME_HOME "$XDG_CONFIG_HOME/wakatime"
set -gx TLDR_CACHE_DIR "$XDG_CACHE_HOME/tldr"
set -gx HAXE_STD_PATH "$HOMEBREW_PREFIX/lib/haxe/std"
set -gx EZA_CONFIG_DIR "$XDG_CONFIG_HOME/eza"
set -gx SYSTEMC_HOME "$HOME/Documents/Binaries/systemc"

zoxide init fish | source

source /Users/rishab/.local/share/opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

fnm env | source

set -gx LC_ALL "en_GB.UTF-8"
```

### Aliases

- Aliases and abbreviations to shorten or modify often-used commands.

```fish

alias cp "cp -i"
alias mv 'mv -i'
alias rm 'rm -i'

function fd # bat
    command fd $argv -X bat
end


alias trash='trash -F'

alias spotify-dlp="yt-dlp --config-locations ~/.config/yt-dlp/config-spotify"

alias vim="nvim"

alias iamb="iamb -C $XDG_CONFIG_HOME"

abbr  --add yadmui "yadm enter lazygit"

function git_clone_and_cd
    git clone $argv[1]
    if test $status -eq 0
        set repo (basename $argv[1] .git)
        cd $repo
    end
end

abbr --add gc git_clone_and_cd
```

### Extensions & Software

- Contains optional dependencies

#### zoxide

- [ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide): `cd` replacement

```fish
if command -q zoxide
    alias cd "z"
    alias .. 'z ..'
end
```

#### eza

- [eza-community/eza](https://github.com/eza-community/eza): `ls` replacement

```fish
if command -q eza
    alias ls 'eza -a1F --color=always --group-directories-first --icons'
    alias la 'eza -aF --color=always --group-directories-first --icons' # all files and dirs
    alias ll 'eza -alF --color=always --group-directories-first --icons' # long format
    alias lt 'eza -aTF --color=always --group-directories-first --icons' # tree listing
end

```

#### aichat

- [sigoden/aichat](https://github.com/sigoden/aichat)

```fish
function _aichat_fish
    set -l _old (commandline)
    if test -n $_old
        echo -n "⌛"
        commandline -f repaint
        commandline (aichat -e $_old)
    end
end
bind \ce _aichat_fish
```

#### Config tangling

```fish
function reload
    gltangle ~/.config/fish/README.md
    source ~/.config/fish/config.fish

    gltangle ~/.config/ghostty/README.md
    ghostty +validate-config
end
```

#### fzf

```fish
set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse'

set fzf_preview_dir_cmd eza --all --color=always
set fzf_fd_opts --hidden --exclude=.git

fzf_configure_bindings --directory=\cf
```

#### lf file manager

```fish
function lf -d "Launch .lf file manager with exit dir cd support"
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

#### asdf version manager

```fish
# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
```

#### gnupg

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


# bind -M visual -m default y "fish_clipboard_copy; commandline -f end-selection repaint-mode"
# bind p forward-char "commandline -i ( pbpaste; echo )[1]" # TODO
```

### Appearance

#### Theme

- Uses [woheedev/onedark-fish](https://github.com/woheedev/onedark-fish), activate by executing `fish_config theme save "One Dark"`

```fish
function fish_greeting
  fastfetch
end
```


#### Prompt

- [starship/starship](https://github.com/starship/starship): custom prompt ([see my config](../starship/README.md))

```fish
set -gx STARSHIP_CONFIG "$XDG_CONFIG_HOME/starship/starship.toml"

function starship_transient_prompt_func
  starship module character
end

function starship_transient_rprompt_func
  starship module time
end

starship init fish | source
enable_transience
```
