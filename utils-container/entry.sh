#!/bin/bash
echo "Installing/Refreshing utilities.."
cp /wsk /opt/utils
cp /cf/cf /opt/utils
cp -R /usr/local/Bluemix /opt/utils/Bluemix
ln -s /opt/utils/Bluemix/bin/bluemix /opt/utils/bx
echo "Done"