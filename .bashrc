# Homebrew
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

# Bat
export BAT_THEME="OneHalfDark"

# XDG
export XDG_STATE_HOME="${HOME}"/.local/state
export XDG_CONFIG_HOME="${HOME}"/.config
export XDG_DATA_HOME="${HOME}"/.local/share
export XDG_CACHE_HOME="${HOME}"/.cache

export HISTFILE="${XDG_STATE_HOME}"/bash/history
