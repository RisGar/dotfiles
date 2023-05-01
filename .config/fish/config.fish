set -gx fish_user_paths $(/opt/homebrew/bin/brew --prefix python)/libexec/bin /Users/rishab/go/bin /Users/rishab/.asdf/shims /opt/homebrew/opt/asdf/libexec/bin /opt/homebrew/sbin /Users/rishab/.emacs.d/bin /Users/rishab/.local/bin /Users/rishab/.cargo/bin '/Applications/Visual Studio Code.app/Contents/Resources/app/bin' /opt/homebrew/bin /opt/homebrew/opt/fzf/bin /opt/homebrew/opt/llvm/bin

zoxide init fish | source
starship init fish | source
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

source /opt/homebrew/opt/asdf/libexec/asdf.fish
source ~/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx GPG_TTY (tty)
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx PAGER "less -r"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx BAT_THEME "OneHalfDark"
set -gx CC "/opt/homebrew/bin/gcc-12"
set -gx CXX "/opt/homebrew/bin/g++-12"

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

set -gx FZF_DEFAULT_OPTS '--cycle --layout=reverse'

set fzf_preview_dir_cmd exa --all --color=always
set fzf_fd_opts --hidden --exclude=.git
fzf_configure_bindings --directory=\cf

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

function fish_user_key_bindings
  fish_vi_key_bindings insert
end

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

bind -M visual -m default y "fish_clipboard_copy; commandline -f end-selection repaint-mode"
bind p forward-char "commandline -i ( pbpaste; echo )[1]" # TODO

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
