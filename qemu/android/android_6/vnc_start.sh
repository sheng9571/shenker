#!/bin/sh
DISPLAY=:$DISPLAY /root/novnc/utils/launch.sh --listen 9287 --vnc localhost:5900 &
sleep 2;
DISPLAY=:$DISPLAY Xvfb :$(echo $DISPLAY | cut -d"." -f1) -ac &
sleep 2;
DISPLAY=:$DISPLAY x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :$(echo $DISPLAY | cut -d"." -f1) -nopw -wait 5 -shared -permitfiletransfer -tightfilexfer -forever -loop -repeat -rfbport 5900 &
sleep 2;
DISPLAY=:$DISPLAY fluxbox &
echo "\n";
