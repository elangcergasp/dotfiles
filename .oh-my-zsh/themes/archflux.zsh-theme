
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%m%{$reset_color%}'
    local user_symbol='%F{reset_color%}#'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%m%{$reset_color%}'
    local user_symbol='%F{reset_color%}$'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%}'
local current_time='%{$terminfo[bold]$fg[yellow]%}%D{%H:%M}%{$reset_color%}'

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
theme_precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats '[%b%c%u%B%F{green}]%F{reset_color}'
    } else {
        zstyle ':vcs_info:*' formats '[%b%c%u%B%F{red}●%F{green}]%F{reset_color}'
    }

    vcs_info
}

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd

local git_branch=' %B%F{green}${vcs_info_msg_0_}%{$reset_color%}'

PROMPT="
╭─${user_host} ${current_time} ${current_dir}${git_branch}
╰─%B${user_symbol}%b "
RPS1="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

