# Basic settings
autoload -U compinit #autocompletion
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.
setopt auto_cd # Change dir without typing cd
autoload -U colors && colors # Enable colors and change prompt
unsetopt nomatch
source ~/.config/zsh/lib/completion.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/dotenv/dotenv.plugin.zsh
source ~/.config/zsh/plugins/extract/extract.plugin.zsh
source ~/.config/zsh/appearancerc
# Setup fzf
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null # Auto-completion
source "/usr/local/opt/fzf/shell/key-bindings.zsh" # Key bindings
export FZF_DEFAULT_OPTS="--no-mouse --height 40% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind 'f4:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept'"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!{.git,node_modules}"'
export FZF_CTRL_T_COMMAND='rg --hidden --no-ignore -l ""'
export FZF_ALT_C_COMMAND='fd -H -t d . $HOME'
# Load aliases and shortcuts
[ -f "$HOME/.config/zsh/keybindrc" ] && source "$HOME/.config/zsh/keybindrc"
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"
# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Start session with tmux
# if [ -z "$TMUX" ] && [ ${UID} != 0 ]
#  then tmux -f /Users/simon/.config/tmux/tmux.conf new -A -s MAIN
# fi

# setopt auto_pushd
# setopt pushd_ignore_dups
# setopt pushdminus
# the other way to auto escape url(apart from unsetopt nomatch)
# autoload -Uz bracketed-paste-magic
# zle -N bracketed-paste bracketed-paste-magic
