# Make completion:
# - Case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
# - Use fzf completion **
autoload -Uz compinit
compinit -d $ZDOTDIR/cache/zcompdump-$ZSH_VERSION
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors '' # Colorize completions using default `ls` colors.
_comp_options+=(globdots)		# Include hidden files.
