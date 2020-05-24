setopt auto_cd # Change dir without typing cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
unsetopt nomatch # Paste url without escape
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

autoload -U compinit
compinit -u
zmodload zsh/complist
# Use vim keys in tab complete menu:
zstyle ':completion:*' menu select
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# Make completion:
# - Case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
_comp_options+=(globdots)		# Include hidden files.
# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

[ -f "$HOME/.config/zsh/appearance.zsh" ] && source "$HOME/.config/zsh/appearance.zsh"
[ -f "$HOME/.config/zsh/keybindrc" ] && source "$HOME/.config/zsh/keybindrc"
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/dotenv/dotenv.plugin.zsh
source "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Start session with tmux
# if [ -z "$TMUX" ] && [ ${UID} != 0 ]
#  then tmux -f /Users/simon/.config/tmux/tmux.conf new -A -s MAIN
# fi

# the other way to auto escape url(apart from unsetopt nomatch)
# autoload -Uz bracketed-paste-magic
# zle -N bracketed-paste bracketed-paste-magic

# source "/usr/local/opt/fzf/shell/key-bindings.zsh"
