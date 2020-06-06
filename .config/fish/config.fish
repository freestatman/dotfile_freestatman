fish_vi_key_bindings

source ~/.aliases

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

