HOME_DIR=( "/home/alex/" "\x1b\[1;34m/\x1b\[0m\x1b\[1;34mhome/\x1b\[0m\x1b\[1;34malex/\x1b\[0m" " ")
DRIVE_DIR=("/media/HDD/" "\x1b\[1;34m/\x1b\[0m\x1b\[1;34mmedia/\x1b\[0m\x1b\[1;34mHDD/\x1b\[0m" " ")
ROOT_DIR=( "/"           "\x1b\[1;34m/\x1b\[0m"                                                 " ")
SYS_DIRS=(HOME_DIR DRIVE_DIR ROOT_DIR)
BEFORE_FNAVI=(sed '"'); for i in $SYS_DIRS; do BEFORE_FNAVI+=("s|^\${"$i"[2]}|\${"$i"[3]}|g;"); done; BEFORE_FNAVI+=('"');
AFTER_FNAVI=(sed '"'); for i in $SYS_DIRS; do AFTER_FNAVI+=("s|^\${"$i"[3]}|\${"$i"[1]}|g;"); done; AFTER_FNAVI+=('"');
B_FN_PLAIN=(sed '"'); for i in $SYS_DIRS; do B_FN_PLAIN+=("s|^\${"$i"[1]}|\${"$i"[3]}|g;"); done; B_FN_PLAIN+=('"');

AUDIO_DIR=(   "Audio/"           "\x1b\[1;34mAudio/\x1b\[0m"                              " ")
PIC_DIR=(     "Pictures/"        "\x1b\[1;34mPictures/\x1b\[0m"                           " ")
VID_DIR=(     "Videos/"          "\x1b\[1;34mVideos/\x1b\[0m"                             " ")
NOTE_DIR=(    "Documents/notes/" "\x1b\[1;34mDocuments/\x1b\[0m\x1b\[1;34mnotes/\x1b\[0m" " ")
DEV_VID_DIR=( "Videos/dev/"      "\x1b\[1;34mVideos/\x1b\[0m\x1b\[1;36mdev/\x1b\[0m"      " ")
DOT_DIR=(     "Dev/alex.files/"  "\x1b\[1;34mDev/\x1b\[0m\x1b\[1;34malex.files/\x1b\[0m"  " ")
USER_DIRS=(DEV_VID_DIR NOTE_DIR AUDIO_DIR PIC_DIR VID_DIR DOT_DIR)
BEFORE_FOPEN=(sed '"'); for i in $USER_DIRS; do BEFORE_FOPEN+=("s|^\${"$i"[2]}|\${"$i"[3]}|g;"); done; BEFORE_FOPEN+=('"');
AFTER_FOPEN=(sed '"'); for i in $USER_DIRS; do AFTER_FOPEN+=("s|^\${"$i"[3]}|\${"$i"[1]}|g;"); done; AFTER_FOPEN+=('"')
PREVIEW_FOPEN=(sed '"'); for i in $USER_DIRS; do PREVIEW_FOPEN+=("s|\${"$i"[3]}|\${"$i"[1]}|g;"); done; PREVIEW_FOPEN+=('"' '<<<' '"$1"')
