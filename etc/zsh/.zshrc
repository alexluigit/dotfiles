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
_comp_options+=(globdots) # Include hidden files when completing.

export LANG=en_US.UTF-8
export ZSH_DATA_DIR=${XDG_DATA_HOME:-~/.local/share}/zsh
export HISTFILE=$ZSH_DATA_DIR/history
export HISTSIZE=100000
export SAVEHIST=100000

export {HTTP_PROXY,HTTPS_PROXY}=http://127.0.0.1:10801
export NO_AT_BRIDGE=1 # Disable a11y
export FZF_DEFAULT_OPTS="--height 50% --reverse --border --bind=ctrl-s:toggle-sort,alt-n:preview-down,alt-p:preview-up"

declare -A PROMPT_ICONS=(
  # [{name}]="{icon}"
  [play_button]=""
  [git_status]=""
  [fingerprint]="󰈷"
  [exclamation]=""
  [package]=""
)

declare -A USER_DIRS=(
  # [{order}_{name}]="{path} {symbol} {program} {description}"
  [01-conf]="$DOTPATH                  System    emacsclient -n"
  [02-code]="/mnt/HDD/Dev              Dev       mpv"
  [03-book]="/mnt/HDD/Book          󰂺   Book      emacsclient -n"
  [04-note]="$HOME/Documents/notes     Notes     emacsclient -n"
  [06-vids]="/mnt/HDD/Video         󰟞   Video     mpv"
  [07-down]="$HOME/Downloads           Downloads mpv"
)

declare -A SYS_DIRS=(
  # [{priority}_{name}]="{path} {symbol} {color}"
  [01_DATA]="/mnt/HDD/  󱛟  220"
  [02_HOME]="$HOME/       152"
  [03_HOME]="$HOME        152"
  [05_CONF]="$DOTPATH/    152"
  [06_ROOT]="/          󰈷  167"
)

. $ZDOTDIR/plugin.zsh
. $ZDOTDIR/fmenu.zsh
. $ZDOTDIR/prompt.zsh
. $ZDOTDIR/venv.zsh
. $ZDOTDIR/aliases.zsh
. $ZDOTDIR/keybind.zsh
case $(uname) in
  Darwin) . $ZDOTDIR/macOS.zsh;;
  Linux) . $ZDOTDIR/linux.zsh;;
esac

autoload -Uz compinit
compinit -d $ZSH_DATA_DIR/zcompdump-$ZSH_VERSION
