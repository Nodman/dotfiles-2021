# You may need to manually set your language environment
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

source $HOME/.zshenv

# Greetings
echo May the force be with you, $LOGNAME!

# autompletion preview
#
# ARM
# source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# x86
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax higlighting, order is important here, otherwise confilct when accepting suggestions
#
# ARM
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# x86
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# vi mode
source /usr/local/share/zsh-vim-mode/zsh-vim-mode.plugin.zsh

# faster nvm

KEYTIMEOUT=1

# VIM_MODE_INITIAL_KEYMAP=vicmd

MODE_CURSOR_VIINS="blinking bar"
MODE_CURSOR_VISUAL="steady block"

MODE_INDICATOR_VIINS='%F{15}%F{8}ins%f'
MODE_INDICATOR_VICMD='%F{10}%F{2}nrm%f'
MODE_INDICATOR_REPLACE='%F{9}%F{1}rpl%f'
MODE_INDICATOR_SEARCH='%F{13}%F{5}src%f'
MODE_INDICATOR_VISUAL='%F{12}%F{4}vis%f'
MODE_INDICATOR_VLINE='%F{12}%F{4}vln%f'

# should come after vi-mode
bindkey '^l' autosuggest-accept

autoload -Uz compinit && compinit

# theme
autoload -U promptinit; promptinit
prompt pure

PURE_PROMPT_SYMBOL=➜
PURE_PROMPT_VICMD_SYMBOL=➜

# colours, please
export CLICOLOR=1

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# BAT theme
export BAT_THEME="Nord"

# Find and remove
fndrm(){
  find $1 -name "$2" | xargs rm
}

# Aliases
alias reload='source $HOME/.zshrc'
alias zshconfig="nvim ~/.zshrc"
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

wd() {
  . /Users/spooner/bin/wd/wd.sh
}

# fnm
export PATH=$HOME/.fnm:$PATH
eval "`fnm env`"
