#!/usr/bin/env bash
BASE_DIR=.

platform='unknown'
unamestr=`uname`
scriptname="$(basename $0)"

if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

find "$BASE_DIR" -maxdepth 1 -type f ! -name "$scriptname" |
 while IFS= read -r file; do
    if [[ $platform == 'linux' ]]; then
        # LINUX
        year="$(date -d "$(stat -c %y "$file")" +%Y)"
        month="$(date -d "$(stat -c %y "$file")" +%b)"
    elif [[ $platform == 'osx' ]]; then
        # OSX
        year=$(stat -f %SB -t %Y "$file")
        month=$(stat -f %SB -t %m "$file")
    fi

    [[ ! -d "$BASE_DIR/$year/$month" ]] && mkdir -p "$BASE_DIR/$year/$month";
    mv "$file" "$BASE_DIR/$year/$month"
done
