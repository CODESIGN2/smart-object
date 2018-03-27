#!/bin/bash

mkdir -p ~/bin
mkdir -p ~/.gimp-2.8/plug-ins
cp ../../bin/smart-object.sh ~/bin/smart-object.sh
cp smart-object.py ~/.gimp-2.8/plug-ins/smart-object.py
chmod +x ~/.gimp-2.8/plug-ins/smart-object.py
