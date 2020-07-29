# Options
setopt AUTO_CD # Change dir without typing cd
setopt AUTO_PUSHD # Push dir into dir stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt APPENDHISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS # Delete empty lines from history file
setopt HIST_IGNORE_SPACE # Ignore a record starting with a space
setopt MENU_COMPLETE # Tab once to get completion directly.
setopt NONOMATCH # Enable url paste without quote
setopt PROMPT_SUBST # Enable prompt parameter expansion, command substitution and arithmetic expansion

# Aspects
source $ZDOTDIR/lib/appearance.zsh
source $ZDOTDIR/lib/widgets.zsh
source $ZDOTDIR/lib/fzf-widgets.zsh
source $ZDOTDIR/lib/fzf-git.zsh
source $ZDOTDIR/lib/alias.zsh
source $ZDOTDIR/lib/completion.zsh
source $ZDOTDIR/lib/keybind.zsh

# Plugins
source $ZDOTDIR/plugins/z/z.sh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/dotenv/dotenv.plugin.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/fzf/shell/completion.zsh 2> /dev/null
