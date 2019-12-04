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
## syntax
#命令	描述
#%F{color} [...] %f	和前面介绍的 $fg 是一样的，但是更简洁。还可以在 F 前面添加数字。
#$fg_no_bold[color]	设置文本为非粗体同时设定文本颜色
#$fg_bold[color]	设置文本为粗体同时设定文本颜色
#$reset_color	重置文本颜色（改为默认颜色）。不会重置粗体设定。使用 %b 来重置粗体设定。可以使用 %f 来简化配置。
#%K{color} [...] %k	设置背景颜色。和非粗体文本颜色一样。任何单一数字前缀会设置背景为黑色。
#Possible color values
#黑 black or 0	红 red or 1
#绿 green or 2	黄 yellow or 3
#蓝 blue or 4	紫 magenta or 5
#青 cyan or 6	白 white or 7
autoload -U colors && colors
PROMPT="["
PROMPT+="$fg[green]%n@$fg[cyan]%M $fg[magenta]%d$reset_color :$fg[red]%i$reset_color]"
PROMPT+="$
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

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

