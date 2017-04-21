#!/bin/sh

echo "Installing/Refreshing Eclipse/Eclim"
rm -fr /ee/*
cp -R /home/macsy/eclipse/* /ee
echo "Done"