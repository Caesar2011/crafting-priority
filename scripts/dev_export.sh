#!/bin/bash

# Get the version from info.json
VERSION=$(grep -o '"version": "[^"]*"' ./info.json | awk -F'"' '{print $4}')

# Create a zip archive
git archive --format=zip --output="HandCraftingPriorityPlus_$VERSION.zip" --prefix="HandCraftingPriorityPlus_$VERSION/" --worktree-attributes HEAD

# Check if cmd.exe exists
if command -v cmd.exe &> /dev/null; then
    # Get the Windows AppData path
    WIN_APPDATA=$(cmd.exe /c echo %appdata% 2> /dev/null)

    # Convert backslashes to forward slashes
    WIN_APPDATA=$(echo "$WIN_APPDATA" | sed 's|\\|/|g')

    # Remove leading/trailing spaces and handle carriage return and newline
    WIN_APPDATA=$(echo "$WIN_APPDATA" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/\r//' -e 's/\n//')

    # Replace single letter drive with /mnt
    WIN_APPDATA=$(echo "$WIN_APPDATA" | sed 's|^\([A-Z]\):|/mnt/\L\1|')

    # Copy the zip file to the Factorio mods folder
    cp HandCraftingPriorityPlus_*.zip "$WIN_APPDATA/Factorio/mods/"
else
    echo "cmd.exe not found. Cannot determine Windows AppData path."
fi
