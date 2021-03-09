#
# Customized zsh configuration
#

# bin PATH
export PATH="$HOME/.bin/:$PATH"

# Aliases
# cpp
#alias cppcompile="c++ -std=c++11 -stdlib=libc++"
# mvim
#alias vim="mvim -v"
# gradle
#alias gradle="JAVA_HOME=`/usr/libexec/java_home -v 1.8` gradle"

# Use vim for editing config files
alias zshconfig="vim $HOME/.zshrc"
alias envconfig="vim $HOME/.bin/env.sh"
# let tmux support 256 colors
alias tmux="tmux -2"


# Pyenv
if [ -e "$HOME/.pyenv" ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Jenv
if [ -e "$HOME/.jenv" ]; then
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

# Nodejs
if [ -e "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    #alias for cnpm
    #alias cnpm="npm --registry=https://registry.npm.taobao.org \
    #  --cache=$HOME/.npm/.cache/cnpm \
    #  --disturl=https://npm.taobao.org/dist \
    #  --userconfig=$HOME/.cnpmrc"
fi


# Rust-lang
if [ -e "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Golang
if [ -e "/opt/go" ]; then
    export GOROOT=/opt/go
    export GOPATH=$HOME/Documents/lang/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# gRPC
if [ -e "/opt/grpc" ]; then
    export PATH=$PATH:/opt/grpc/bin
fi

# Qt
#if [ -e "/opt/Qt/Tools/QtCreator" ]; then
#    QTDIR=/opt/Qt/Tools/QtCreator
#    PATH=$QTDIR/bin:$PATH
#    LD_LIBRARY_PATH=$QTDIR/lib:$LD_LIBRARY_PATH
#    export QTDIR PATH LD_LIBRARY_PATH
#fi

# Proxy related functions
setproxy() {
  export {http,https,ftp}_proxy="http://3.20.128.5:88"
}

unsetproxy() {
  unset {http,https,ftp}_proxy
}

# GOProxy related functions
setgoproxy() {
  export GO111MODULE=on
  export GOPROXY=https://goproxy.cn
}

unsetgoproxy() {
  unset GO111MODULE
  unset GOPROXY
}
