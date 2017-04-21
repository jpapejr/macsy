#!/bin/bash
echo "Ensuring project structure exists in volume"
mkdir -p /projects/node
mkdir -p /projects/go
mkdir -p /projects/java
mkdir -p /projects/perl
mkdir -p /projects/ruby
mkdir -p /projects/python
mkdir -p /projects/misc
chmod ugo+rw -R /projects
echo "Done"
tail -f /dev/null