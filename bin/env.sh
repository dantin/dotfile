#!/bin/zsh

# Aliases
alias cppcompile="c++ -std=c++11 -stdlib=libc++"

# Use sublime-text for editing config files
alias zshconfig="subl $HOME/.zshrc"
alias envconfig="subl $HOME/.bin/env.sh"

# Python environment
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Java environment
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# alias for mvim
alias vim="mvim -v"

# alias for gradle
alias gradle="JAVA_HOME=`/usr/libexec/java_home -v 1.8` gradle"

#alias for cnpm
#alias cnpm="npm --registry=https://registry.npm.taobao.org \
#  --cache=$HOME/.npm/.cache/cnpm \
#  --disturl=https://npm.taobao.org/dist \
#  --userconfig=$HOME/.cnpmrc"
#
# Customized PATH
export PATH="$HOME/.bin/:$PATH"

# Rust-lang
export PATH="$HOME/.cargo/bin:$PATH"

# Golang
export GOROOT=/usr/local/Cellar/go/1.10.2/libexec
export GOPATH=$HOME/Documents/code/golang
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
