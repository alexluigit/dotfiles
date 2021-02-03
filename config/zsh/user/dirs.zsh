declare -A USER_DIRS=(
   # [{order}_{name}]="{path} {symbol} {program} {description}"
   [01-conf]="/home/alex/Dev/alex.files/      nvim    System"
   [02-code]="/media/HDD/Dev/                 mpv     Dev"
   [03-note]="/home/alex/Documents/notes/     nvim    Notes"
   [04-pics]="/home/alex/Pictures/            sxiv    Pictures"
   [05-vids]="/home/alex/Video/               mpv     Video"
   [06-home]="/home/alex/                     nvim    Home"
   [07-root]="/                               nvim    All files"
)

declare -A SYS_DIRS=(
   # [{priority}_{name}]="{path} {symbol} {color}"
   [00_DATA]="/media/HDD/    220"
   [00_HOME]="/home/alex/    152"
   [01_ROOT]="/              167"
)

# spaces after symbol
SYM_OFFSET=" "
