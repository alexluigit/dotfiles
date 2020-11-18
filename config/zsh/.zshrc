# Options
setopt AUTO_CD # Change dir without typing cd
setopt CD_SILENT
setopt AUTO_PUSHD # Push dir into dir stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS # Delete empty lines from history file
setopt HIST_IGNORE_SPACE # Ignore a record starting with a space
setopt MENU_COMPLETE # Tab once to get completion directly.
setopt NONOMATCH # Enable url paste without quote
setopt PROMPT_SUBST # Enable prompt parameter expansion, command substitution and arithmetic expansion
setopt IGNORE_EOF # C-d will not exit shell

# Aspects
for file in $(ls $ZDOTDIR/lib); do; . $ZDOTDIR/lib/$file; done

# Plugins
source $ZDOTDIR/plugins/z/z.sh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/fzf/shell/completion.zsh
