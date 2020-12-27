#!/bin/bash

echo "Enter the number from 3 to 76, 20 will be used as a sensible default with no arguments"
echo "Warning, 1-2 levels are making the screen completely black"

BRIGHTNESS=$1

if [ "$BRIGHTNESS" == "" ]; then
    BRIGHTNESS="20"
fi

sudo su -c "echo $BRIGHTNESS >/sys/class/backlight/intel_backlight/brightness"
