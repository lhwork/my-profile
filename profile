
OSNAME="$(uname -s)"

case $OSNAME in
    "Darwin")
        export IS_MAC_OS_X=1
        export OS_GREETING="Mac OS X"
    ;;
    "Linux")
        export IS_LINUX=1
        export OS_GREETING="Linux"
    ;;
esac

# functions
unshift_path() {
    new_path="$1"
    echo $PATH | grep -q -s "$new_path"
    if [ $? -eq 1 ]; then
        PATH="$new_path":"$PATH"
    fi
    export PATH
}

unshift_path "/opt/local/bin"
unshift_path "/opt/local/sbin"
unshift_path "/usr/local/git/bin"
unshift_path "/usr/local/mongodb/bin"
unshift_path "/usr/local/mysql/bin"
unshift_path "/usr/local/scala-2.8.1/bin"
unshift_path "/usr/local/nginx/sbin"

#if [ -f ~/bin/bash_completion ]; then
#    . ~/bin/bash_completion
#fi

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# golang
export GOROOT=$HOME/Code/go
unshift_path "$GOROOT/bin"

# build mac os programs
if [ $IS_MAC_OS_X ]; then
    export ARCHFLAGS='-arch i386 -arch x86_64'
fi

# prompt
source ~/bin/git-completion.bash
source ~/bin/git-flow-completion.bash
#PS1='[\u@\h:\w\[\033[0;32m\]$(__git_ps1 "(%s)")\033[0m]\$ '
PS1='[\u:\w\[\033[0;32m\]$(__git_ps1 "(%s)")\033[0m]\$ '

# alias
alias ll='ls -l'
alias py26='workon py26'


