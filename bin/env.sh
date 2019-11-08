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

# Use sublime-text for editing config files
alias zshconfig="vim $HOME/.zshrc"
alias envconfig="vim $HOME/.bin/env.sh"

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
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && source "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
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
if [ -e "/usr/local/Cellar/go" ]; then
    export GOROOT=/usr/local/Cellar/go/1.12.6/libexec
    export GOPATH=$HOME/Documents/code/golang
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# Proxy related functions
function setproxy() {
  export {http,https,ftp}_proxy="http://3.20.128.5:88"
}

function unsetproxy() {
  unset {http,https,ftp}_proxy
}
