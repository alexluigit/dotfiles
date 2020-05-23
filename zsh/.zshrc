autoload -U compinit #autocompletion
zstyle ':completion:*' menu select
# zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
setopt auto_cd # Change dir without typing cd
autoload -U colors && colors # Enable colors and change prompt
unsetopt nomatch # Paste url without escape
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
source ~/.config/zsh/lib/completion.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/dotenv/dotenv.plugin.zsh
source ~/.config/zsh/plugins/extract/extract.plugin.zsh
source ~/.config/zsh/appearancerc
[ -f "$HOME/.config/zsh/keybindrc" ] && source "$HOME/.config/zsh/keybindrc"
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"
source "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Start session with tmux
# if [ -z "$TMUX" ] && [ ${UID} != 0 ]
#  then tmux -f /Users/simon/.config/tmux/tmux.conf new -A -s MAIN
# fi

# the other way to auto escape url(apart from unsetopt nomatch)
# autoload -Uz bracketed-paste-magic
# zle -N bracketed-paste bracketed-paste-magic

# source "/usr/local/opt/fzf/shell/key-bindings.zsh"
