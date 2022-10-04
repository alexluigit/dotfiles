setopt AUTO_CD # Change dir without typing cd
setopt CD_SILENT
setopt AUTO_PUSHD # Push dir into dir stack
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exits.
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS # Delete empty lines from history file
setopt HIST_IGNORE_SPACE # Ignore a record starting with a space
setopt MENU_COMPLETE # Tab once to get completion directly.
setopt NONOMATCH # Enable url paste without quote
setopt PROMPT_SUBST # Enable prompt parameter expansion, command substitution and arithmetic expansion
setopt IGNORE_EOF # C-d will not exit shell
autoload -U colors && colors # Enable colors
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors '' # Colorize completions using default `ls` colors.
_comp_options+=(globdots)		# Include hidden files.
ZSH_DATA_DIR=$XDG_DATA_HOME/zsh
_Z_DATA=$XDG_DATA_HOME/z/zdata
export NO_AT_BRIDGE=1 # Disable a11y
export {HTTP_PROXY,HTTPS_PROXY}=http://127.0.0.1:10801
export FZF_DEFAULT_OPTS="--height 50% --reverse --border --bind=ctrl-s:toggle-sort,alt-n:preview-down,alt-p:preview-up"

declare -A USER_DIRS=(
  # [{order}_{name}]="{path} {symbol} {program} {description}"
  [01-conf]="/opt/dotfiles/                    System    emacsclient -n"
  [02-code]="/mnt/HDD/Dev/                     Dev       mpv"
  [03-book]="/mnt/HDD/Book/                    Book      emacsclient -n"
  [04-note]="/home/$USER/Documents/notes/      Notes     emacsclient -n"
  [06-vids]="/mnt/HDD/Video/                   Video     mpv"
  [07-down]="/home/$USER/Downloads/            Downloads mpv"
)
declare -A SYS_DIRS=(
  # [{priority}_{name}]="{path} {symbol} {color}"
  [01_DATA]="/mnt/HDD/        220"
  [02_HOME]="/home/$USER/     152"
  [03_HOME]="$HOME            152"
  [04_CONF]="/opt/dotfiles/   152"
  [05_ROOT]="/                167"
)

PLUGINS=(rupa/z
         zsh-users/zsh-autosuggestions
         zsh-users/zsh-syntax-highlighting)

# Load necessary functions for bootstraping
. $ZDOTDIR/boot.zsh

# Load config
CONDA_PROMPT=true
CONDA_AUTOSWITCH=false
TIMER_PROMPT=false
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-word)
declare -A ZSH_HIGHLIGHT_STYLES=(
  [alias]=fg=yellow,bold
  [builtin]=fg=blue,bold
  [function]=fg=yellow,bold
  [command]=fg=blue,bold
)
. $ZDOTDIR/fmenu.zsh
. $ZDOTDIR/prompt.zsh
zsh-defer . $ZDOTDIR/aliases.zsh
zsh-defer . $ZDOTDIR/keybind.zsh
zsh-defer . $ZDOTDIR/conda.zsh

# Load plugins
zsh-defer . /usr/share/fzf/completion.zsh
zsh-defer . $ZSH_DATA_DIR/plugins/z/z.sh
zsh-defer . $ZSH_DATA_DIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer . $ZSH_DATA_DIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz compinit
compinit -d $ZSH_DATA_DIR/zcompdump-$ZSH_VERSION
