# Options
setopt auto_cd # Change dir without typing cd
setopt auto_pushd # Push dir into dir stack
setopt pushd_ignore_dups
setopt pushdminus
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS # Delete empty lines from history file
setopt HIST_IGNORE_SPACE # Ignore a record starting with a space
setopt MENU_COMPLETE # Tab once to get completion directly.

# Aspects
source "$ZDOTDIR/function.zsh"
source "$ZDOTDIR/appearance.zsh"
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/completion.zsh"
source "$ZDOTDIR/keybind.zsh"

# Plugins
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/dotenv/dotenv.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
