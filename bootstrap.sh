#!/usr/bin/env bash

set_symbolic_links() {
    local symbolic_link_table=(               \
        "vimrc, vimrc, .vimrc"                \
        "vim configuration, vim-config, .vim" \
        "tmux, dotfile/tmux.conf, .tmux.conf")

    for i in "${!symbolic_link_table[@]}"; do
        IFS=', ' read -r -a entry <<< "${symbolic_link_table[i]}"
        echo " Set for ${entry[0]}"
        echo "${entry[1]}" \
             "${entry[2]}"
    done

}

set_symbolic_links
#cd $HOME
#ln -s documents/code/dotfile/vimrc .vimrc
#ln -s documents/code/vim-config/ .vim
#ln -s documents/code/dotfile/tmux.conf .tmux.conf
