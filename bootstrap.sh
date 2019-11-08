#!/usr/bin/env bash

cd $(dirname "${BASH_SOURCE[0]}")
BASE_PATH="$(pwd)"

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0'  ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

#### main

# .bin
if [ -L $HOME/.bin ] && [ -e $HOME/.bin ]; then
    msg "\"$HOME/.bin\" ready"
else
    msg "Create symboic link \"$HOME/.bin\" -> \"$BASE_PATH/bin\""
    ln -s $BASE_PATH/bin $HOME/.bin
fi

# .tmux.conf
if [ -L $HOME/.tmux.conf ] && [ -e $HOME/.tmux.conf ]; then
    msg "\"$HOME/.tmux.conf\" ready"
else
    msg "Create symboic link \"$HOME/.tmux.conf\" -> \"$BASE_PATH/tmux.conf\""
    ln -s $BASE_PATH/tmux.conf $HOME/.tmux.conf
fi
