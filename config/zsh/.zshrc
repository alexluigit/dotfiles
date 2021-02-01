for file in $(/bin/ls $ZDOTDIR/user); do; . $ZDOTDIR/user/$file; done
for file in $(/bin/ls $ZDOTDIR/lib); do; . $ZDOTDIR/lib/$file; done
# Plugin config, source in the end
_Z_DATA=$XDG_DATA_HOME/z/.z
. /usr/share/z/z.sh
. /usr/share/fzf/completion.zsh
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(ctrl-return)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(ctrl-semi)
. /usr/share/zsh/plugins/zsh-autosuggestions-git/zsh-autosuggestions.zsh
declare -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=blue,bold
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
