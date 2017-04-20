#!/bin/bash
Xvfb :1 -screen 0 1024x768x24 &

cd /home/macsy/eclipse
DISPLAY=:1 ./eclipse/eclimd -b

emacs --daemon
