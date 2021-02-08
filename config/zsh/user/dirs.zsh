declare -A USER_DIRS=(
   # [{order}_{name}]="{path} {symbol} {program} {description}"
   [01-conf]="/home/alex/Dev/alex.files/      nvim    System"
   [02-code]="/media/HDD/Dev/                 mpv     Dev"
   [03-book]="/media/HDD/Book/                zathura Book"
   [04-note]="/home/alex/Documents/notes/     nvim    Notes"
   [05-pics]="/home/alex/Pictures/            sxiv    Pictures"
   [06-vids]="/home/alex/Video/               mpv     Video"
   [07-home]="/home/alex/                     nvim    Home"
)

declare -A SYS_DIRS=(
   # [{priority}_{name}]="{path} {symbol} {color}"
   [00_DATA]="/media/HDD/    220"
   [00_HOME]="/home/alex/    152"
   [01_ROOT]="/              167"
)

# spaces after symbol
SYM_OFFSET=" "
