#
# Customized zsh configuration
#

# bin PATH
export PATH="$HOME/.bin/:$HOME/bin/:$PATH"

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
bindkey \^K kill-line

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Pyenv - Lazy loading for faster startup
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# Lazy load pyenv
if [[ -d "$PYENV_ROOT" ]]; then
  pyenv() {
    unset -f pyenv
    eval "$(command pyenv init -)"
    eval "$(command pyenv virtualenv-init -)"
    pyenv "$@"
  }
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
  export {http,https,ftp}_proxy="http://proxy.private.com:3128"
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

# Jenv - Lazy loading for faster startup
export PATH="$HOME/.jenv/bin:$PATH"
# Lazy load jenv
if [[ -d "$HOME/.jenv" ]]; then
  jenv() {
    unset -f jenv
    eval "$(command jenv init -)"
    jenv "$@"
  }
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export VDP_MODE=v2
