#!/usr/bin/env bash

BIN_ROOT_PATH=$(readlink $HOME/.bin)

source $BIN_ROOT_PATH/utils/common.sh

####################### SETUP FUNCTIONS
find_top_files() {
    local path="$1"
    local size="$2"

    msg "Trying to find top files in directory: $path"

    if [ -e "$path" ]; then
        find $path -type f -exec du -Sh {} + | sort -rh | head -n $size
        ret="$?"
        success "Done"
    fi
}

####################### MAIN()

size=5
directory=$(pwd)

if [ $# -gt 1 ]; then
    while [ "$1" != "" ]; do
        case $1 in
            -s | --size )
                shift
                size=$1
                ;;
            *)
                directory=$1
                ;;
        esac
        find_top_files $directory $size

        shift
    done
    exit 0
fi

# default find in current working directory
find_top_files $directory \
               $size
