.profile of MAC OS Lion 
=======================

bash completion
---------------

    sudo port install bash-completion

git completion
--------------

    curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash > git-completion.bash

 1. place it in a `bash-completion.d` fold.

    mv git-completion.bash <dir>/bash-completion.d/

 2. place it in User's HOME fold.

    mv git-completion.bash ~/.git-completion.bash

 3. edit .profile file.

    source ~/.git-completion.bash

    PS1='[\u:\w\[\033[0;32m\]$(__git_ps1 "(%s)")\033[0m]\$ '

git flow completion
-------------------

    curl https://raw.github.com/bobthecow/git-flow-completion/master/git-flow-completion.bash > git-flow_completion.bash

 (the same)

virtualenv
----------

 1. edit .profile file.

    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh

