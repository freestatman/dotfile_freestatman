
fish_vi_key_bindings 

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
alias fishrc='vim ~/.config/fish/config.fish'
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

# docker 
alias drun='docker run --rm  '
alias dps='docker ps -a '
alias drm='docker rm '
alias dstart='docker start '
alias dstop='docker stop '

#--- git
alias gs="git status "
alias ga="git add "
alias gl="git log "
alias gc="git commit -m "
alias gd="git diff "
alias gdt="git difftool "
#alias gr="git rm \$(git ls-files --deleted) " # note: has to add \ before $ for this kind of alias

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

# function
function f
    echo f
    ls -ahF --color=auto -l | grep --color=auto $argv
end

function f1
    echo f
    ls -ahF --color=auto | grep --color=auto $argv
end

function hg
    history | grep $argv | grep -v hsearch;
end

function md
    mkdir $argv; chmod g+w $argv
end

