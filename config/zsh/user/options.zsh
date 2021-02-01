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
autoload -U colors && colors # Enable colors
autoload -Uz compinit
compinit -d $XDG_DATA_HOME/zsh/zcompdump-$ZSH_VERSION
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors '' # Colorize completions using default `ls` colors.
_comp_options+=(globdots)		# Include hidden files.
