# Aspects
for file in $(ls $ZDOTDIR/user); do; . $ZDOTDIR/user/$file; done
for file in $(ls $ZDOTDIR/lib); do; . $ZDOTDIR/lib/$file; done

# Plugins
source $ZDOTDIR/plugins/z/z.sh
_Z_DATA=$XDG_DATA_HOME/z/.z

source $ZDOTDIR/plugins/fzf/shell/completion.zsh

source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(ctrl-\')
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(ctrl-\;)

source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=blue,bold
