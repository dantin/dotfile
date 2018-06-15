#!/usr/bin/env bash

####################### SETUP PARAMETERS
[ -z "$SCRIPTS_BASE_DIR" ] && SCRIPTS_BASE_DIR="$HOME/.bin"
source_dir="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

####################### BASIC SETUP TOOLS
####################### BASIC SETUP TOOLS
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

variable_set() {
    if [ -z "$1" ]; then
        error "You must have your HOME environmental variable set to continue."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
}

####################### SETUP FUNCTIONS

create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    msg "Trying to linking scripts in $target_path"

    if [ ! -e "$source_path" ] || [ ! -e "$target_path" ]; then
        error "'$source_dir' or '$target_path' NOT exists!"
    else
        for filename in $source_dir/*.sh; do
            local source_file="$filename"
            local target_file="$target_path/$( basename "$filename" )"

            lnif "$source_file" "$target_file"
            success "Success link file '$source_file' to '$target_file'"
        done
        ret="$?"
        success "Create symlinks done"
    fi
}

####################### MAIN()

variable_set "$HOME"

create_symlinks "$source_dir" "$SCRIPTS_BASE_DIR"

