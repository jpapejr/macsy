#!/bin/sh
sleep 2
Xvfb :1 -screen 0 1024x768x24 &
DISPLAY=:1 /home/macsy/eclipse/eclimd