#!/bin/bash

set -eo pipefail

npm run build

# Get the version from info.json
VERSION=$(grep -o '"version": "[^"]*"' ./info.json | awk -F'"' '{print $4}')
echo "$VERSION" > VERSION_FILE

# Create a zip archive
uploadStash=$(git stash create);
git archive --format=zip --output="HandCraftingPriorityPlus_$VERSION.zip" --prefix="HandCraftingPriorityPlus_$VERSION/" --worktree-attributes "${uploadStash:-HEAD}"

# Get the current changelog as description
changelog=$(cat changelog.txt)

# Extract the section for the specified version
section=$(echo "$changelog" | awk -v version="$VERSION" '/Version:/ {if ($2 == version) {flag=1} else {flag=0}} flag')

# Omit lines without spaces at the beginning
section=$(echo "$section" | grep -E '^\s')

# Remove up to 3 spaces from the beginning of each line
section=$(echo "$section" | sed 's/^\s\{,3\}//')

# Add an additional empty line before and after a line ending with a colon
section=$(echo "$section" | sed 's/^\(.*:\)$/\n\1\n/')

# Save the output as DESCRIPTION_FILE
echo "$section" > DESCRIPTION_FILE
