# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
export SYSTEMD_PAGER=

unset rc

# ----------------------------------------------------------------------

unalias -a 

export PS1='\[\033[0m\][\u@\h \W]\$ '

alias vi=vimx
export EDITOR=vimx
export VISUAL=vimx

alias ls='ls -p'
alias cc='cc -masm=intel'
alias gcc='gcc -masm=intel'
alias objdump='objdump -M intel'
alias ip='ip -color=never'
alias pdfgrep='pdfgrep --color=never'

export BACKUP_DIR="$HOME/.backup"
export NOTES_DIR="$HOME/.notes"
export MUSIC_DIR="$HOME/Music"

export GOPATH="$HOME/.go"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/home/s/.nim-2.0.0/bin

# https://no-color.org/
export NO_COLOR=1 

export LS_COLORS=':st=:tw=:ow='
export TREE_COLORS=''

export GREP_COLORS='bn=:cx=:fn=33:ln=90:mc=:ms=:se=30:sl='

# ----------------------------------------------------------------------

export PAGER=pg

export GROFF_NO_SGR=0 
export MANWIDTH=80

export LESS='--ignore-case --jump-target=.5 --RAW-CONTROL-CHARS --tilde'
export LESS_TERMCAP_md=$'\E[0m' # no bold
export LESS_TERMCAP_us=$'\E[0m' # no underline

export MANLESS="\ Manual\ page\ \$MAN_PN\ ?ltline\ %lt?L/%L.:byte\ %bB?s/%s..?\ (END):?pB\ %pB\\%.."

# ----------------------------------------------------------------------

if [ -f "$HOME/.fzf.conf" ]; then
  . "$HOME/.fzf.conf"
fi

# ----------------------------------------------------------------------

j() {
  dir="$(__jump_dir "$@")"
  if [ -n "$dir" ]; then
    cd -- "$dir"
    pwd
  fi
}

killjobs() {
  jobs -p | xargs kill 2>/dev/null
  disown -a 2>/dev/null
}
