#!/bin/bash
/Users/simon/Applications/ariaTracker;
killall aria2c;
kill $(ps aux | grep app.js\ -p\ 10001 | awk '{print $2}'); 
/usr/local/aria2/bin/aria2c -D --conf-path=/Users/simon/.config/aria2/aria2.conf; 
/usr/local/bin/node /Users/simon/Applications/UnblockNeteaseMusic/app.js -p 10001:10002



