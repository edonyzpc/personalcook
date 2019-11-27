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
#命令			描述
#%F{color} [...] %f	和前面介绍的 $fg 是一样的，但是更简洁。还可以在 F 前面添加数字。
#$fg_no_bold[color]	设置文本为非粗体同时设定文本颜色
#$fg_bold[color]		设置文本为粗体同时设定文本颜色
#$reset_color		重置文本颜色（改为默认颜色）。不会重置粗体设定。使用 %b 来重置粗体设定。可以使用 %f 来简化配置。
#%K{color} [...] %k	设置背景颜色。和非粗体文本颜色一样。任何单一数字前缀会设置背景为黑色。
#Possible color values
#黑 black or 0	红 red or 1
#绿 green or 2	黄 yellow or 3
#蓝 blue or 4	紫 magenta or 5

autoload -U colors && colors
PROMPT="[%{$fg[green]%}%n@%{$fg[cyan]%}%M %{$fg[magenta]%}%d%{$reset_color%} :%{$fg[red]%}%!%{$reset_color%}]$
> "
