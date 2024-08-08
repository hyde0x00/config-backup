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

set -o vi

export PS1='[\u@\h \W]\$ '

bind 'set show-all-if-ambiguous on'
bind 'set page-completions off'
bind 'set match-hidden-files off'
bind 'set completion-query-items 0'
bind 'set enable-bracketed-paste off'

shopt -s checkwinsize

# ----------------------------------------------------------------------

unalias -a 

alias vi=vimx
export EDITOR=vimx
export VISUAL=vimx

alias ls='ls -h -F -G'
alias tree='tree -F'
alias df='df -h -T'
alias du='du -h'
alias ipcs='ipcs --human'
alias cal='cal -m'

alias dmesg='dmesg --color=never'
alias pdfgrep='pdfgrep --color=never'

alias cc='cc -masm=intel'
alias gcc='gcc -masm=intel'
alias objdump='objdump -M intel'

alias diff='diffcolor'

# ----------------------------------------------------------------------

export BACKUP_DIR="$HOME/.backup"
export NOTES_DIR="$HOME/.notes"

export GOPATH="$HOME/.go"
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:/home/s/.nim-2.0.0/bin

# ----------------------------------------------------------------------

# https://no-color.org/
export NO_COLOR=1

export LS_COLORS=':st=:tw=:ow='
export TREE_COLORS=''

export GCC_COLORS=''

# ----------------------------------------------------------------------

export PAGER=pg
export LESS='--ignore-case --tilde --jump-target=.5 --RAW-CONTROL-CHARS'
export MANLESS="\ Manual\ page\ \$MAN_PN\ ?ltline\ %lt?L/%L.:byte\ %bB?s/%s..?\ (END):?pB\ %pB\\%.."
export MANWIDTH=80
export GROFF_NO_SGR=0 
export LESS_TERMCAP_md=$'\E[0m' # no bold
export LESS_TERMCAP_us=$'\E[0m' # no underline

# ----------------------------------------------------------------------

killjobs() {
        jobs -p | xargs kill 2>/dev/null
	while disown; do disown; done &>/dev/null
}

j() {
	_dir="$(__jump_dir "$@")"

	if [ -n "$_dir" ]; then
		cd -- "$_dir" && pwd
	fi
}

# ----------------------------------------------------------------------

if [ -f "$HOME/.fzf.conf" ]; then
	. "$HOME/.fzf.conf"
fi

# ----------------------------------------------------------------------

# https://discussion.fedoraproject.org/t/how-to-fix-bash-vte-prompt-command-command-not-found-when-using-tmux/74847
# https://bugs.archlinux.org/task/36170

__vte_osc7()
{
    printf "\033]7;file://%s%s\033\\" "${HOSTNAME}" "$(/usr/libexec/vte-urlencode-cwd)"
}

__vte_prompt_command()
{
    local command=$(HISTTIMEFORMAT= history 1 | sed 's/^ *[0-9]\+ *//');
    command="${command//;/ }";
    local pwd='~';
    [ "$PWD" != "$HOME" ] && pwd=${PWD/#$HOME\//\~\/};
    pwd="${pwd//[[:cntrl:]]}";
    printf '\033]777;notify;Command completed;%s\033\\\033]777;precmd\033\\\033]0;%s@%s:%s\033\\' "${command}" "${USER}" "${HOSTNAME%%.*}" "${pwd}";
    __vte_osc7
}

export PROMPT_COMMAND="__vte_prompt_command; history -a; history -c; history -r"

# ----------------------------------------------------------------------

export HISTCONTROL="erasedups:ignoreboth"
export HISTFILESIZE=5000 
export HISTSIZE=500

shopt -s histappend

# ----------------------------------------------------------------------

clean_bash_history() {
	unq -r ~/.bash_history | sponge ~/.bash_history
	rm ~/.bash_history-*.tmp 2>/dev/null
}

trap clean_bash_history EXIT
