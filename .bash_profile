## N.B. .bash_profile is executed for login shells, while .bashrc is
## executed for interactive non-login shells.
# https://emacs.stackexchange.com/questions/28995/bash-profile-or-bashrc-for-shell-in-emacs

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

###############################################################################
# SSH-AGENT trap and eval
#  Skylar's solution: Make sure ssh-agent1 and ssh-agent2 die on logout
if [[ `uname` == "Linux" ]]; then
    trap ' test -n "$SSH_AGENT_PID" && eval `ssh-agent -k` && echo "ssh-agent -k execute completed" ; test -n "$SSH2_AGENT_PID" && kill $SSH2_AGENT_PID' 0
    echo "Trap executed successfully. Now testing if SSH_AUTH_SOCK is an empty string"
    # If no agent is running and we have a terminal, run ssh-agent and ssh-add.
    if [ "$SSH_AUTH_SOCK" = "" ]; then
        eval `ssh-agent`; 
        echo "eval ssh-agent executed. Now ssh_auth_sock = " $SSH_AUTH_SOCK
        /usr/bin/tty > /dev/null && ssh-add 
    fi
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/wnoble/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/wnoble/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/wnoble/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/wnoble/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

