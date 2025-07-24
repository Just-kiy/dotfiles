#!/bin/bash

CURRENT="$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep -w "KeyboardLayout Name" | cut -f2 -d "=" | tr -d ' ;' | tr -d '"')"

if [ "$CURRENT" = "Russian" ]; then
    sketchybar --set "$NAME" label="RU"
elif [ "$CURRENT" = "ABC" ]; then
    sketchybar --set "$NAME" label="EN"
else
    sketchybar --set "$NAME" label="$CURRENT"
fi
