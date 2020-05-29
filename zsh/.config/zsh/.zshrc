setopt auto_cd # Change dir without typing cd
setopt auto_pushd # Push dir into dir stack
setopt pushd_ignore_dups
setopt pushdminus
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS # Delete empty lines from history file
setopt HIST_IGNORE_SPACE # Ignore a record starting with a space
unsetopt nomatch # Paste url without escape
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$ZDOTDIR/cache/history
autoload -U colors && colors # Enable colors and change prompt
# Make completion:
# - Case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
autoload -Uz compinit
compinit -u
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors '' # Colorize completions using default `ls` colors.
_comp_options+=(globdots)		# Include hidden files.

# TODO: clear up to /usr/local/share using symlink
[ -f "$ZDOTDIR/appearance.zsh" ] && source "$ZDOTDIR/appearance.zsh"
[ -f "$ZDOTDIR/keybindrc" ] && source "$ZDOTDIR/keybindrc"
[ -f "$ZDOTDIR/aliasrc" ] && source "$ZDOTDIR/aliasrc"
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/dotenv/dotenv.plugin.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Start session with tmux
# if [ -z "$TMUX" ] && [ ${UID} != 0 ]
#  then tmux -f /Users/simon/.config/tmux/tmux.conf new -A -s MAIN
# fi

# the other way to auto escape url(apart from unsetopt nomatch)
# autoload -Uz bracketed-paste-magic
# zle -N bracketed-paste bracketed-paste-magic

# source "/usr/local/opt/fzf/shell/key-bindings.zsh"
