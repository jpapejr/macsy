#!/bin/sh
Xvfb :1 -screen 0 1024x768x24 &
sleep 2
DISPLAY=:1 /home/macsy/eclipse/eclimd
