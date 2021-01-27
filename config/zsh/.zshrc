for file in $(/bin/ls $ZDOTDIR/user); do; . $ZDOTDIR/user/$file; done
for file in $(/bin/ls $ZDOTDIR/lib); do; . $ZDOTDIR/lib/$file; done
. $ZDOTDIR/lib/.plugin-config.zsh
