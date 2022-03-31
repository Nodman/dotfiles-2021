# ------------------------------------------------------
# You may need to manually set your language environment
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

# ENV if it's exists
[ -f $HOME/.zshenv ] && source $HOME/.zshenv

# Greetings
echo May the force be with you, $LOGNAME!
# ------------------------------------------------------

#options
setopt autocd

ARCH=$(uname -m)
SHARE="/usr/local/share"

if [[ "$ARCH" == 'arm64' ]]; then
  fpath+=/opt/homebrew/share/zsh/site-functions
  SHARE="/opt/homebrew/share"
fi

# wd
wd() {
  . $SHARE/wd/wd.sh
}

# autompletion preview
source $SHARE/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax higlighting, order is important here, otherwise confilct when accepting suggestions
source $SHARE/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# vi mode
source $SHARE/zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh

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

# BAT theme
export BAT_THEME="Nord"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Find and remove
fndrm(){
  find $1 -name "$2" | xargs rm
}

# wake up nvim rather then create new window
# won't work because nvim started from nv() have empty job name
# need aonther way around
nv() {
  jobs_list=$(echo `jobs -l | awk "{print  $  5 }" | grep htop`)

  echo $jobs_list

  if [ ${#jobs_list} -gt 0 ]; then
    fg nvim
  else
    nvim "$@"
  fi
}

# Aliases
alias reload='source $HOME/.zshrc'
alias zshconfig="nvim $HOME/.zshrc"
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ssh='TERM=xterm-256color ssh'

# FZF
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# convert with ffmpeg (HDR -> SDR)
fmpg(){
  ffmpeg -i $1 -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p -c:v libx264 -crf 17 -preset slower $2
}

# ruby (may need to be djusted for intel arch)
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# rbenv
export PATH="$HOME/.rbenv/shims:$PATH"
# source $HOME/.rbenv/completions/rbenv.zsh
eval "$(rbenv init - zsh)"

# fnm
NODE_BINARY=$(which node)
export PATH=$HOME/.fnm:$PATH
export NODE_BINARY=$NODE_BINARY
eval "$(fnm env --use-on-cd)"

# issues with xcode finding node when building RN projects
alias ln-node='ln -s $NODE_BINARY /usr/local/bin/node'
alias unln-node='rm /usr/local/bin/node'

# rust cargo

export PATH="$HOME/.cargo/bin:$PATH"
