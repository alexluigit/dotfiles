# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Locale
export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"

# Use vim keys in tab complete menu:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# Include hidden files in autocomplete:
_comp_options+=(globdots)
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# --------------------------------  Setup ZSH  -----------------------------------
export ZSH="$HOME/.config/oh-my-zsh"
ZSH_THEME="gitster"
export TERM="xterm-256color"
source $ZSH/oh-my-zsh.sh
# compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
plugins=(git vi-mode)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# --------------------------------------------------------------------------------

# ---------------------------------- Vi-mode -------------------------------------
bindkey -v
export KEYTIMEOUT=1
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}
# --------------------------------------------------------------------------------

# --------------------------------  Setup fzf  -----------------------------------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi
# Auto-completion
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
# Key bindings
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
# Init
export FZF_DEFAULT_OPTS="--no-mouse --height 40% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind 'f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept'"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!{.git,node_modules}'"
# --------------------------------------------------------------------------------

# Load aliases and shortcuts
[ -f "$HOME/.config/zsh/keybindrc" ] && source "$HOME/.config/zsh/keybindrc"
[ -f "$HOME/.config/zsh/aliasrc" ] && source "$HOME/.config/zsh/aliasrc"

# Start session with tmux
if [ -z "$TMUX" ] && [ ${UID} != 0 ]
 then tmux -f /Users/simon/.config/tmux/tmux.conf new -A -s MAIN
fi
