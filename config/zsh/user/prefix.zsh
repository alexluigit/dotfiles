HOME_DIR=( "/home/alex/" "\x1b\[38;5;152m\x1b\[0m " " ")
DRIVE_DIR=("/media/HDD/" "\x1b\[38;5;220m\x1b\[0m " " ")
ROOT_DIR=( "/"           "\x1b\[38;5;167m\x1b\[0m " " ")
SYS_DIRS=(HOME_DIR DRIVE_DIR ROOT_DIR)
NAVI_B=(sed '"'); for i in $SYS_DIRS; do NAVI_B+=("s|^\${"$i"[1]}|\${"$i"[2]}|g;"); done; NAVI_B+=('"');
NAVI_A=(sed '"'); for i in $SYS_DIRS; do NAVI_A+=("s|^\${"$i"[3]}|\${"$i"[1]}|g;"); done; NAVI_A+=('"');
