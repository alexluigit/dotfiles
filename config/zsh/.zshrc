for file in $(/bin/ls $ZDOTDIR/user); do; . $ZDOTDIR/user/$file; done
for file in $(/bin/ls $ZDOTDIR/lib); do; . $ZDOTDIR/lib/$file; done
# Plugin config, source in the end
_Z_DATA=$XDG_DATA_HOME/z/.z
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(ctrl-return)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(ctrl-semi)
declare -A ZSH_HIGHLIGHT_STYLES=([alias]=fg=yellow,bold [builtin]=fg=blue,bold
[function]=fg=yellow,bold [command]=fg=blue,bold)
. /usr/share/z/z.sh
. /usr/share/fzf/completion.zsh
. /usr/share/zsh/plugins/zsh-autosuggestions-git/zsh-autosuggestions.zsh
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
