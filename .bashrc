
#  prompt {{{

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

export HISTIGNORE=' *:ls:lt:pwd:clear:cd:q:b:h:fg:e:ll:tp:td:tr:sl:R:qA:qB:qstat:w:who:..:screen'

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
#define BLACK "\033[22;30m"
#define RED "\033[22;31m"
#define GREEN "\033[22;32m"
#define BROWN "\033[22;33m"
#define BLUE "\033[22;34m"
#define PURPLE "\033[22;35m"
#define CYAN "\033[22;36m"
#define GREY "\033[22;37m"
#define DARK_GREY "\033[01;30m"
#define LIGHT_RED "\033[01;31m"
#define LIGHT_GREEN "\033[01;32m"
#define YELLOW "\033[01;33m"
#define LIGHT_BLUE "\033[01;34m"
#define LIGHT_PURPLE "\033[01;35m"
#define LIGHT_CYAN "\033[01;36m"
#define WHITE "\033[01;37m"

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[22;36m\]\u@\[\033[22;36m\]\h:\[\033[01;34m\]\w\[\033[01;32m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

#}}}

# alias {{{

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
fi

#-------------------
# Personnal Aliases
#-------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i' # Prevents accidentally clobbering files.
alias c='clear; ls -hF --color=auto'
alias mkdir='mkdir -p'
alias h='history'
alias j='jobs -l'
# The 'ls' family (this assumes you use the GNU ls)
alias ll="ls -alF --color=auto"
alias la='ls -Al'               # show hidden files
alias ls='ls -ahF --color=auto' # add colors for filetype recognition
alias lx='ls -lXB'              # sort by extension
alias lk='ls -lSr'              # sort by size
alias lc='ls -lcr'              # sort by change time
alias lu='ls -lur'              # sort by access time
alias lt='ls -altr'             # sort by date
alias ltt='ls -altr | tail'     # sort by date
alias l='ls -altr'              # sort by date
alias lm='ls -al |more'         # pipe through 'more'
alias tree='tree -Csu'          # nice alternative to 'ls'

alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'
alias last='vim `ls -t|head -n1`'
alias last2='vim -O `ls -t|head -n2`'
alias last3='vim -p `ls -t|head -n3`'
alias cl='cat `ls -t|head -n1`'
alias cl2='cat `ls -t|head -n2`'
alias hl='head -v `ls -t|head -n1`'
alias hl2='head -v `ls -t|head -n2`'
#alias tl='tail -v `ls -t|head -n1`'
#alias tl2='tail -v `ls -t|head -n2`'
alias wl='wc -l'
#alias top='top -h'
alias xi='xargs -I []'

alias b='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .4='cd ../../..'
alias .5='cd ../../../..'

#}}}

# File & strings related functions: {{{
function gg()
{ head -n1 $2 ; grep $1 $2; }
# Find a file with a pattern in name:
function f()
{ ls -l | grep $* ; }
function f1()
{ ls    | grep $* ; }
function ff()
{ find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
    Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    local SMSO=$(tput smso)
    local RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print0 |
    xargs -0 grep -sn ${case} "$1" 2>&- | \
    sed "s/$1/${SMSO}\0${RMSO}/gI" | more
}

function lowercase()  # move filenames to lowercase
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

#}}}

# archive function {{{
function a1()
{
        today=`date +%Y%m%d_%s`
    if [ -e $1 ]; then
        if [ ! -d archived ]; then mkdir archived; fi
        #export FILENAME=`echo $1 | awk -F '.' '{print $1}'`
        #export SUFF=`echo $1 | awk -F '.' '{print $NF}'`
        #mv $1 archived/${FILENAME}_swa_`date +%m%d%y`.$SUFF
        mv $1 archived/$1_swa_`date +%m%d%y_%s`
    else
        echo "$1 not found."
    fi
}

function a()
{
    if [ -e $1 ]; then
        if [ ! -d archived ]; then mkdir archived; fi
        #export FILENAME=`echo $1 | awk -F '.' '{print $1}'`
        #export SUFF=`echo $1 | awk -F '.' '{print $NF}'`
        #cp $1 archived/${FILENAME}_swa_`date +%m%d%y`.$SUFF
        cp $1 archived/$1_swa_`date +%m%d%y_%s`
    else
        echo "$1 not found."
    fi
}

# }}}

# qa function {{{
function qa()
{
    if [ -e $1 ]; then
        export from=`pwd`
        to=$(sed 's/\/DEV/\/QA\/PR/' <<< $from)

        export FILENAME=`echo $1 | awk -F '.' '{print $1}'`
        export SUFF=`echo $1 | awk -F '.' '{print $NF}'`

        if [ -e $to/${FILENAME}_swa0.$SUFF ]; then
            filelast=`ls $to/${FILENAME}_swa* | tail -n1`
            export iter=`echo $filelast | grep -o 'swa[0-9]\.' | grep -o '[0-9]'`
            ((iter++))
            cp -i $1 $to/${FILENAME}_swa${iter}.$SUFF
            echo "$1 --> next QA version .../QA/PR/${FILENAME}_swa${iter}.$SUFF"
        else
            cp -i $1 $to/${FILENAME}_swa0.$SUFF
            cp -i $1 $to/${FILENAME}_swa1.$SUFF
            chmod -w $to/${FILENAME}_swa0.$SUFF
            echo "$1 --> $to/${FILENAME}_swa0.$SUFF"
            echo "$1 --> $to/${FILENAME}_swa1.$SUFF"
        fi
    else
        echo "$1 not found."
    fi
}

function g2qa()
{
    export from=`pwd`
    to=$(sed 's/\/DEV/\/QA\/PR/' <<< $from)

    if [ -d $to ]; then
        cd $to
    else
        echo "$to not found."
    fi
}

function qa1()
{
    if [ -e $1 ]; then
        export iter=`echo $1 | grep -o 'swa[0-9]' | grep -o '[0-9]'`
        export FILENAME=`echo $1 | awk -F "swa$iter." '{print $1}'`
        export SUFF=`echo $1 | awk -F "swa$iter." '{print $2}'`
        ((iter++))
        cp -i $1 ${FILENAME}swa${iter}.$SUFF
        echo "$1 --> next QA version ./${FILENAME}swa${iter}.$SUFF"
    else
        echo "$1 not found."
    fi
}

#}}}

# Compression shortcuts {{{
#tar.gz
tg() {
    tarfile=$1
    shift
    tar -czvf $tarfile $@
}

#tar.bz2
tb() {
    tar --bzip2 -cvf $tarfile $@
}

# Extract various compression formats
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

#}}}

# more alias, e.g. path, git, tmux, screen, {{{

#---- Cluster ----
alias qA="qsub -I -q A -l nodes=owl15"
alias qB="qsub -I -q B"
alias qexpress="qsub -I -q express"
alias e='exit'
alias q='qstat | grep swa'
alias qs='qstat -s'
alias qn='qstat -n'

# 1000G DATA
alias 1kg="cd /home/bssi/RandD/PUBLIC_DATABASE/1000GENOMES/1000G_phase3_v5_20130502"

#----- Rscript ----
alias r="/usr/local/bin/Rscript --verbose"
alias r1="R CMD BATCH "

#----- Screen -----
alias sr="screen -r "
alias ss="screen -S "
alias sl="screen -ls "
alias sx="screen -x "
alias cleanscreen="screen -ls | tail -n +2 | head -n -2 | awk '{print $1}' | xargs -I{} screen -S {} -X quit"

#--- git
alias gs="git status "
alias ga="git add "
alias gl="git log "
alias gc="git commit -m "
alias gd="git diff "
alias gdt="git difftool "
alias gr="git rm \$(git ls-files --deleted) " # note: has to add \ before $ for this kind of alias


#--- gnome
alias go="gnome-open "

#--- sedi
alias sedi="sed -f .sed -i "

#--- touch
alias t="touch "

export PATH=$PATH:$HOME/local/bin

alias ta="tmux attach -t "
alias tl="tmux ls"
alias tn="tmux new -s "
alias findme="find . -maxdepth 1 -user swa "

# 2016 alias 
alias ty='tail -f /var/log/messages'
alias p='ps aux | grep -i'
#alias m='mysql -p'
alias d='du -sh'
#alias tcga="ssh -i ~/keys/tcga.key c182209@ec2-54-242-128-61.compute-1.amazonaws.com"
alias r="readlink -f"

#}}}

# functions to check log/er/out files {{{
function log()
{ 
    bsnm=$(printf '%s\n' "$1" | sed -r '$s/\.(pl|R|r|sh)$//I')    
    vim -O `ls ./LOGS_AND_LISTS/$bsnm*log` `ls ./LOGS_AND_LISTS/$bsnm*Rout`; 
}
function er() 
{ 
    bsnm=$(printf '%s\n' "$1" | sed -r '$s/\.(pl|R|r|sh)$//I')    
    vim -O `ls ./LOGS_AND_LISTS/$bsnm*er`; 
}

# }}}

# utility shell functions {{{

#----- History
hg() { history | grep $1 | grep -v hsearch; }


function md()
{ mkdir $1; chmod g+w $1; }

function mdqa()
{
    today=`date +%Y%m%d`
    if [ -d archived ]; then
        mkdir -p archived/qa_rerun_$today
        chmod g+w archived/qa_rerun_$today
        echo "archived/qa_rerun_$today created"
    else
        echo "archived/ folder not exist"
    fi
}


#----------------------------------------------------------------------------
function sy
{ 
    if [ -f .conf ] ; then
        source .conf #--- set from/to path
        for f in `find $from -maxdepth 1 -not -type d -and -not -name ".*" -printf "%f\n"`; do
            if [ -f $to/$f ]; then
                diff -q $from/$f $to/$f >/dev/null
                comp_value=$?
                if [ $comp_value -eq 1 ]; then
                    if [ ! -d $to/archived ]; then mkdir $to/archived; fi
                    mv $to/$f $to/archived/${f}_swa_`date +%m%d%y_%s`
                    cp $from/$f $to/$f;
                    echo "$to/$f: changed"
                fi
            else
                cp $from/$f $to/$f;
                echo "$f: --> $to/$f"
            fi
        done
    else
        echo "There is no conf file"
    fi
}


function ss()
{ 
    if [ -f .conf ] ; then
        source .conf #--- set from/to path
        if [ -f $to/$1 ]; then
            source $to/$1
            echo "$to/$1 is running "
        else
            echo "$to/$1 not exist "
        fi
    else
        echo "conf file not exist"
    fi
}





#----- check whether all the same
function dif
{
    if [ -f .conf ] ; then
        source .conf #--- set from/to path
        for f in `find $from -maxdepth 1 -not -type d -and -not -name ".*" -printf "%f\n"`; do
            if [ -f $to/$f ]; then
                diff -q $from/$f $to/$f >/dev/null
                comp_value=$?
                if [ $comp_value -eq 1 ]; then
                    echo "$f: is different"
                fi
            else
                echo "$f: doesn't exist in $to"
            fi
        done
    else
        echo "There is no conf file"
    fi
}

function difvim
{
    if [ -f .conf ] ; then
        source .conf #--- set from/to path
        for f in `find $from -maxdepth 1 -not -type d -and -not -name ".*" -printf "%f\n"`; do
            if [ -f $to/$f ]; then
                diff -q $from/$f $to/$f >/dev/null
                comp_value=$?
                if [ $comp_value -eq 1 ]; then
                    echo "$f: is different"
                    vimdiff $from/$f $to/$f
                fi
            else
                echo "$f: doesn't exist in $to"
            fi
        done
    else
        echo "There is no conf file"
    fi
}


#--- csvlook
csvlook(){
    # $1 should be a csv file
    head -n1 $1 > ~/csv.tmp
    cat $1 >> ~/csv.tmp
    sed 's/"//g;s/,/\t|\t/g' ~/csv.tmp | sed '2s/[^|\t]/-/g' | column -t
    rm -f ~/csv.tmp
}


function pwdw
{
    pwd | sed 's/\//\\/g' | sed 's/^/\\/'
}

# }}}

# subr series functions: 2016 bash functions {{{
function subr
{
    #----------------------------------------------------------------------------
    # $1 argument is the R code scode name
    # $2 argument is the name of the job running on the cluster, by default is subr
    # $3 argument is the dependent job ids
    pg_dir=`pwd`;
    er_dir=${pg_dir}/system_files;
    lg_dir=${pg_dir}/system_files;
    if [ $2 ]; then qname=$2;  else qname=subr; fi;
    if [ -e $1 ]; then
        rcode=$1;
        echo "module load R; cd $pg_dir; R CMD BATCH --no-save --no-restore $rcode $lg_dir/$rcode.Rout" | qsub -N $qname -o $er_dir/$rcode.ou -e $er_dir/$rcode.er; # -j y
    else
        echo "$1 not found.";
        echo "$PWD";
    fi
}



function subs
{
    pg_dir=`pwd`
    er_dir=${pg_dir}/system_files
    lg_dir=${pg_dir}/system_files

    #----------------------------------------------------------------------------
    # $1 argument is the R code file name
    # $2 argument is the name of the job running on the cluster, by default is subs
    # $3 argument is the dependent job ids
    if [ $2 ]; then qname=$2;  else qname=subs; fi
    if [ -e $1 ]; then
        scode=$1
        echo "cd $pg_dir; sh $scode > $lg_dir/$scode.log" | qsub -N $qname -e $er_dir/$scode.er -o $er_dir/$scode.ou
    else
        echo "$1 not found."
        echo "$PWD";
    fi
}
# }}}

# functions to init project structure {{{

function init_prj
# $1 is the project folder name
# $2 is the permission
{
    echo Project folder name is $1
    if [ $1 ]; then nm=$1;  else nm=; fi;
    if [ $2 ]; then perms=$2;  else perms=750; fi;
    mkdir $nm

    mkdir -m $perms -p $nm/prog/dev/archived
    mkdir -m $perms -p $nm/prog/qa/archived
    mkdir -m $perms -p $nm/prog/prd
    mkdir -m $perms -p $nm/prog/dev/system_files
    mkdir -m $perms -p $nm/prog/qa/system_files
    mkdir -m $perms -p $nm/prog/prd/system_files

    mkdir -m $perms -p $nm/data/dev/archived
    mkdir -m $perms -p $nm/data/qa/archived
    mkdir -m $perms -p $nm/data/prd

    mkdir -m $perms -p $nm/out/dev/archived
    mkdir -m $perms -p $nm/out/qa/archived
    mkdir -m $perms -p $nm/out/prd

    mkdir -m $perms -p $nm/report/archived
    mkdir -m $perms -p $nm/doc/archived
    mkdir -m $perms -p $nm/validation/archived
}

#}}}

# 2017 google cloud gcloud {{{

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/freeman/gCloud/google-cloud-sdk/path.bash.inc' ]; then source '/home/freeman/gCloud/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/freeman/gCloud/google-cloud-sdk/completion.bash.inc' ]; then source '/home/freeman/gCloud/google-cloud-sdk/completion.bash.inc'; fi

# }}}

# environment setup (keep this bottom)  {{{
export EDITOR="vim"
set -o vi
tmux
#}}}

# render rmarkdown file {{{
function rmd
{
    module load R/3.3.2
    echo "rmarkdown::render('$1')" | R --vanilla --slave
}

#}}}

# history {{{
export HISTSIZE=100000
export HISTFILESIZE=2000
#}}}


