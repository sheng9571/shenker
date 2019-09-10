#!/bin/sh
killall -q fluxbox;
sleep 1;
killall -q x11vnc;
sleep 1;
killall -q Xvfb;
sleep 1;
pkill -f launch.sh;
echo "\n";
