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

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8


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
if [ -e "/usr/local/go" ]; then
    export GOROOT=/usr/local/go
    export GOPATH=$HOME/Documents/lang/go
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# perl5
# By default non-brewed cpan modules are installed system-wide.
# using `local:lib` to persist module across updates.
#
# set up using:
#   PERL_MM_OPT="INSTALL_BASE=$HOME/Documents/lang/perl5" cpan local::lib
#   echo 'eval "$(perl -I$HOME/Documents/lang/perl5/lib/perl5 -Mlocal::lib=$HOME/Documents/lang/perl5)"' >> ~/.zshrc
if [ -e "$HOME/Documents/lang/perl5" ]; then
    eval "$(perl -I$HOME/Documents/lang/perl5/lib/perl5 -Mlocal::lib=$HOME/Documents/lang/perl5)"
fi

# Proxy related functions
setproxy() {
  export {http,https,ftp}_proxy="http://3.20.128.5:88"
}

unsetproxy() {
  unset {http,https,ftp}_proxy
}

setgoproxy() {
    export GO111MODULE=on
    export GOPROXY=https://goproxy.cn
}

unsetgoproxy() {
    unset GO111MODULE
    unset GOPROXY
}
