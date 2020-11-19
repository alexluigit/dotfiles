HOME_DIR=( "/home/alex/" "\x1b\[1;34m/\x1b\[0m\x1b\[1;34mhome/\x1b\[0m\x1b\[1;34malex/\x1b\[0m" " ")
DRIVE_DIR=("/media/HDD/" "\x1b\[1;34m/\x1b\[0m\x1b\[1;34mmedia/\x1b\[0m\x1b\[1;34mHDD/\x1b\[0m" " ")
ROOT_DIR=( "/"           "\x1b\[1;34m/\x1b\[0m"                                                 " ")
SYS_DIRS=(HOME_DIR DRIVE_DIR ROOT_DIR)
NAVI_B=(sed '"'); for i in $SYS_DIRS; do NAVI_B+=("s|^\${"$i"[2]}|\${"$i"[3]}|g;"); done; NAVI_B+=('"');
NAVI_A=(sed '"'); for i in $SYS_DIRS; do NAVI_A+=("s|^\${"$i"[3]}|\${"$i"[1]}|g;"); done; NAVI_A+=('"');
NAVI_BP=(sed '"'); for i in $SYS_DIRS; do NAVI_BP+=("s|^\${"$i"[1]}|\${"$i"[3]}|g;"); done; NAVI_BP+=('"');
