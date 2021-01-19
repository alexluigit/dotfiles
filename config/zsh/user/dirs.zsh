declare -A USER_DIRS=(
   # [{order}_{name}]="{path} {symbol} {program} {description}"
   [01-conf]="/home/alex/Dev/alex.files/      nvim    System config"
   [02-code]="/media/HDD/Dev/                 mpv     Coding tutorial"
   [03-note]="/home/alex/Documents/notes/     nvim    Notes"
   [04-pics]="/home/alex/Pictures/            sxiv    Pictures"
   [05-vids]="/home/alex/Videos/              mpv     Videos"
   [06-home]="/home/alex/                     nvim    Home"
   [07-root]="/                               nvim    All files"
)

# 1.symbol 2.path 3.color
HOME_DIR=( "" "/home/alex/" "152")
DRIVE_DIR=("" "/media/HDD/" "220")
ROOT_DIR=( "" "/"           "167")
SYS_DIRS=(HOME_DIR DRIVE_DIR ROOT_DIR)
SYM_OFFSET=" "
