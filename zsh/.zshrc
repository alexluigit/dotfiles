# Options
setopt AUTO_CD # Change dir without typing cd
setopt AUTO_PUSHD # Push dir into dir stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHDMINUS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS # Delete empty lines from history file
setopt HIST_IGNORE_SPACE # Ignore a record starting with a space
setopt MENU_COMPLETE # Tab once to get completion directly.
setopt NONOMATCH # This will enable url paste without quote

# Aspects
source "$ZDOTDIR/function.zsh"
source "$ZDOTDIR/fzf-widgets.zsh"
source "$ZDOTDIR/appearance.zsh"
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/completion.zsh"
source "$ZDOTDIR/keybind.zsh"

# Plugins
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/dotenv/dotenv.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/plugins/fzf/shell/completion.zsh" 2> /dev/null
