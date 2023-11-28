#!/bin/bash

set -eo pipefail

# Function to bump version
bump_version() {
    # Read version from info.json
    version=$(jq -r .version info.json)

    echo "here $version"

    # Parse version components
    major=$(echo "$version" | cut -d '.' -f 1)
    minor=$(echo "$version" | cut -d '.' -f 2)
    patch=$(echo "$version" | cut -d '.' -f 3)
    echo "here1 $major $minor $patch"

    # Bump version based on argument
    set +eo pipefail
    case "$1" in
        "patch") ((patch++));;
        "minor") ((minor++)); patch=0;;
        "major") ((major++)); minor=0; patch=0;;
        *) echo "Invalid argument. Use 'patch', 'minor', or 'major'."; exit 1;;
    esac
    set -eo pipefail
    echo "here2 $major $minor $patch"

    # Create new version
    new_version="$major.$minor.$patch"
    echo "here3 $new_version"

    # Update package.json and info.json
    jq ".version = \"$new_version\"" package.json > tmp_package.json && mv tmp_package.json package.json
    jq ".version = \"$new_version\"" info.json > tmp_info.json && mv tmp_info.json info.json

    # Update changelog.txt
    today=$(date +"%d.%m.%Y")
    changelog="---------------------------------------------------------------------------------------------------
Version: $new_version
Date: $today"

    echo -e "$changelog\n$(cat changelog.txt)" > changelog.txt

    echo "Version bumped to $new_version. Changelog updated."
}

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <patch|minor|major>"
    exit 1
fi

# Run the bump_version function
bump_version "$1"
