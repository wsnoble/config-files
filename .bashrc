## N.B. .bash_profile is executed for login shells, while .bashrc is
## executed for interactive non-login shells.
# https://emacs.stackexchange.com/questions/28995/bash-profile-or-bashrc-for-shell-in-emacs

# Warn user about not having a .bash_profile, .bash_login, or .profile
if [ ! -r ~/.bash_profile ] && [ ! -r ~/.bash_login ] && [ ! -r ~/.profile ]; then
  echo "** WARNING, you do not have a .bash_profile, .bash_login, or a .profile."
fi

# Allow core files to be created.
# ulimit -c unlimited

###############################################################################
# ALIASES
###############################################################################

# Combine commit and push.
alias git-commit="git commit -a -m \!* ; git push"

# Mark directories with trailing slashes.
alias ls='/bin/ls -F'

# Do ps only with my listings.
alias ps='ps -fu$USER'

# A good font for XWindows on a console.
BIGFONT="-sony-fixed-medium-r-normal--24-230-75-75-c-120-iso8859-1"

# A good font for XWindows on a 15-inch monitor.
SMALLFONT="-b\&h-lucidatypewriter-bold-r-normal-sans-14-140-75-75-m-90-iso8859-1"

alias bigterm="xterm +ls -geometry 80x25+0+30 -title \!* -n \!* -font $BIGFONT -sb -sl 128 -cu -e ssh \!* &"
alias smallterm="xterm +ls -geometry 80x25+0+0 -title \!* -n \!* -font $SMALLFONT -sb -sl 128 -cu -e rlogin \!* &"
alias bigemacs="emacs -fn $BIGFONT -geometry 80x44+0+0 &"
alias smallemacs="emacs -fn $SMALLFONT -geometry 80x44+0+0 --basic-display &"

# Start a nice job in the background
alias startjob="nohup nice ./runall >& runall.`hostname`.out &"

# Do an svn status, but skip files not under version control.
alias svn-status='svn status | grep -v "^[?]"'

# Look for a pattern in all C++ files under the current directory.
alias rgrep="grep -R --include=*.{cc,cxx,c,cpp} \!* ."

# Status of my jobs in the queue.
alias qstatus="qstat -u wnoble | awk '\$5 == \"r\"' | wc -l; qstat -u wnoble | wc -l"

###############################################################################
# ENVIRONMENT VARIABLES
###############################################################################

# Store the location of the bibtex repository.
export BIBINPUTS="~/proj/noble-lab-references::"
 
# Needed for gnuplot
export GDFONTPATH=/usr/share/fonts/liberation
export GNUPLOT_DEFAULT_GDFONT=LiberationSans-Regular

# Location of my utilities.
export PATH=${PATH}:~/bin

# Stuff to do on a Mac.
if [[ `uname` == "Darwin" ]]; then
    # Path for Macports.
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    # Needed for inetutils.
    export PATH=/opt/local/libexec/gnubin:$PATH
    # Copied from Crux installation instructions.
    export CC=/usr/bin/gcc
    export CXX=/usr/bin/g++

    # For Casanovo to use the GPU.
    export PYTORCH_ENABLE_MPS_FALLBACK=1

else
  # Manage the ssh agent, if we are attached to a tty.
  if /usr/bin/tty > /dev/null; then
    ssh-add -l | grep 'no identities' > /dev/null
    echo "ssh-add -l | grep 'no identities' > /dev/null executed"
    if [ $? -eq 0 ]; then 
      #Load your default identity.
      ssh-add 
    fi
  fi
fi


# Set up the path using the 'module' program.
if  ! [ -z $MODULESHOME ]; then
  module load modules modules-init 
  module load modules-gs
  module load modules-noble

  if [[ "${MODULES_REL}" = "RHEL6" ]]; then
    
    module load mercurial/latest
    module load git/latest
    module load emacs/latest
    module load texlive/latest
    module load thunderbird/latest

    module load latex2rtf/2.3.2a
    
    # Required for Crux build
    module load gmp/5.0.2
    module load mpc/0.8.2
    module load mpfr/3.1.0
    module load gcc/4.9.1
    module load cmake/3.12.0
    
    module load autoconf/latest
    module load automake/latest
    
    module load gnuplot/4.6.4
    
    module load cucumber/1.2.1
    module load cucumber-cpp/latest
    module load cppspec/latest

  elif [[ "${MODULES_REL}" = "CentOS7" ]]; then
    module load git/2.18.0
    module load texlive/20180608

# N.B. Using /net/noble/vol1/home/noble/miniconda3
#    module load python/3.6.5
    
    module load autoconf/2.69
    module load automake/1.16.1
    module load gcc/10.2.0
    module load cmake/3.17.3
    # module load boost/1.70.0
    
    module load gnuplot/4.6.4
    module load cucumber/3.1.2
    
  fi
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/net/noble/vol1/home/noble/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/net/noble/vol1/home/noble/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/net/noble/vol1/home/noble/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/net/noble/vol1/home/noble/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

