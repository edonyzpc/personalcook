# config
if [[ ! "$PATH" == */Users/edony/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/edony/bin"
fi
# for go
export GOPATH="/Users/edony/go"
export GOBIN="${GOPATH}/bin"
export PATH="${PATH}:${GOBIN}"
# for rust
export PATH="${PATH}:$HOME/.cargo/bin"

# prompt
autoload -U colors && colors
PS1=""
PROMPT="["
PROMPT+="$fg[green]%n@$fg[cyan]%M $fg[magenta]%d$reset_color :$fg[red]%i$reset_color"
PROMPT+="]$
>> "
#RPROMPT="$fg[yellow]%?$reset_color"

# alias
alias logdev='ssh pengchen.zpc@100.88.105.44'
alias dcode='docker run -w /home/edony/ -u edony -v ~/code:/home/edony/code -it edony/github:latest bash'

# terminal config
export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias rm='rm -iv'
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp -t'                    # Preferred 'ls' implementation
alias llf='ls -la | grep "^-" | wc -l'      # Counter the number of files
alias lld='ls -lA | grep "^d" | wc -l'      # Counter the number of directions
alias lla='ls -lA | egrep "^-|^d" | wc -l'  # Counter the number of all
alias less='less -FSRXc'                    # Preferred 'less' implementation
function pvim()                             # Use wildcard to open file with vim
{
    name=$(ll | egrep $1 | sed 's/.* //g') # ...find the name of file with wildcard
    echo "Opening File..."
    echo $name
    if [ -z $name ];then
        echo "No Matching file"
    else
        vim $name                           # ...open the 'name' file
    fi
}
#cd() { builtin cd "$@"; ll;}                # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias edit='subl'                           # edit:         Opens any file in sublime editor
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop

# lr:  Full Recursive Directory Listing
# ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

# Set Default Editor (change 'Nano' to the editor of your choice)
# ------------------------------------------------------------
export EDITOR=/usr/bin/vim

