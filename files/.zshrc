# Esoteric things I don't understand
bindkey -e
zstyle :compinstall filename '/home/kasm-user/.zshrc'
autoload -Uz compinit
compinit

# ZMV is cool :3
autoload -U zmv

# A thing
autoload colors && colors

# Configure command history
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
HISTFILE=~/.histfile
HISTSIZE=1200
SAVEHIST=1000

# Fancy up-down history search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "$terminfo[kcuu1]" history-beginning-search-backward-end
bindkey "${terminfo[kcud1]}" history-beginning-search-forward-end

# Set up prompt
setopt PROMPT_SUBST

. /usr/lib/git-core/git-sh-prompt

COLOUR_THEME=blue

PROMPT='%F{${COLOUR_THEME}}%B%K{${COLOUR_THEME}} %F{white}%K{${COLOUR_THEME}}%B%n@%m%b%F{${COLOUR_THEME}}%k█▓▒%b%k%f$(__git_ps1) %% '
RPROMPT="%F{${COLOUR_THEME}}%B%~/%b%k%f"

# Aliases
alias ls='ls --color=auto --group-directories-first -Fh'
alias ll='ls --color=auto --group-directories-first -Fhl'
alias la='ls --color=auto --group-directories-first -Fha'
alias lla='ls --color=auto --group-directories-first -Fhal'
alias grep='grep --color=auto'

alias fzn='nano $(fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}")'
alias fzp='fzf --preview "batcat --color=always --style=numbers --line-range=:500 {}"'
alias fd='fdfind'
alias bat='batcat'

# initalise zoxide
eval "$(zoxide init zsh)"

# include global .zshrc
[ -f /etc/zshrc ] && source /etc/zshrc

# include local .zshrc
[ -f .zshrc_local ] && source .zshrc_local