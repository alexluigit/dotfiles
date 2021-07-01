declare -A USER_DIRS=(
  # [{order}_{name}]="{path} {symbol} {program} {description}"
  [01-conf]="/home/alex/Code/alex.files/     nvim    System"
  [02-code]="/media/HDD/Dev/                 mpv     Dev"
  [03-book]="/media/HDD/Book/                zathura Book"
  [04-note]="/home/alex/Documents/notes/     nvim    Notes"
  [05-pics]="/home/alex/Pictures/            sxiv    Pictures"
  [06-vids]="/home/alex/Video/               mpv     Video"
  [07-down]="/home/alex/Downloads/           mpv     Downloads"
)
declare -A SYS_DIRS=(
  # [{priority}_{name}]="{path} {symbol} {color}"
  [00_DATA]="/media/HDD/    220"
  [00_HOME]="/home/alex/    152"
  [01_ROOT]="/              167"
)
declare -A ZSH_HIGHLIGHT_STYLES=(
  [alias]=fg=yellow,bold
  [builtin]=fg=blue,bold
  [function]=fg=yellow,bold
  [command]=fg=blue,bold
)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(ctrl-return)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(ctrl-bslash)

for file in $(/bin/ls $ZDOTDIR); do . $ZDOTDIR/$file; done
. /usr/share/z/z.sh
. /usr/share/fzf/completion.zsh
. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
