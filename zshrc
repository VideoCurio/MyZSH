# © 2023 David BASTIEN for videocurio.com
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Expand PATH
export PATH=/usr/sbin:$PATH

# Set path if required
#export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

# Aliases
if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias ll='ls -lah --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias src="source $HOME/.zshrc"                                             # reload zsh configuration
alias history="history -E 0"                                                # Force zsh to show the complete history with timestamp
alias update="sudo apt update && sudo apt upgrade -y && flatpak update"     # Debian all in one update
alias cool="neofetch"                                                       # I always forget about this command name

# override default python virtualenv indicator in prompt
#VIRTUAL_ENV_DISABLE_PROMPT=1
virtualenv_info() { 
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

# Set up the prompt
autoload -Uz promptinit && promptinit
# Define custom theme, like fade but better IMO, see https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
prompt_mytheme_setup() {
    #prompt_symbol=🤖
    #prompt_symbol=🚀
    prompt_symbol=😎
    folder_symbol=📂
    clock_symbol=🕓

    font_color='white'
    bg_color='green' # black, red, green, yellow, blue, magenta, cyan or white
    if [ "$EUID" -eq 0 ]; then
        prompt_symbol=💀
        bg_color='red'
        font_color='white'
    elif [ "$EUID" -lt 1000 ]; then
        prompt_symbol=🤖
        bg_color='yellow'
        font_color='white'
    fi

    PROMPT_DIRECTORY="%K{blue}%F{$bg_color}"$'\xe2\x97\xa4'" ${folder_symbol} %F{white}%~ "
    PROMPT_TIME="%K{yellow}%F{blue}"$'\xe2\x97\xa4'" ${clock_symbol} %F{white}%D{%T (%Z)}"
    PROMPT_END="%k%b%F{yellow}"$'\xe2\x97\xa4'"%F{reset}"
    PROMPT_NEWLINE="$prompt_newline %B%F{$bg_color}"$'\xe2\xa4\xb7'"%b%f "
    PS1="%B%K{$bg_color}%F{$font_color} ${prompt_symbol} %n@%m $PROMPT_DIRECTORY$PROMPT_TIME$PROMPT_END$PROMPT_NEWLINE"
}
# Add the custom theme to promptsys
prompt_themes+=( mytheme )
# And load it
prompt mytheme
#prompt fade blue yellow white            # a default Zsh Prompt Theme

# Use vi keybindings even if our EDITOR is set to vi
#bindkey -e

# Keep 5000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt INC_APPEND_HISTORY           # append command to history file
#export HISTTIMEFORMAT="%F %T "     # History time format ? bash format ?
setopt EXTENDED_HISTORY             # record command start time
setopt HIST_FIND_NO_DUPS            # do not save duplicated command

# Use modern completion system
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Colors prompt
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
        . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_STYLES[default]=none
        ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
        ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[path]=bold
        ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[command-substitution]=none
        ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[process-substitution]=none
        ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[assign]=none
        ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
        ZSH_HIGHLIGHT_STYLES[named-fd]=none
        ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
        ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
        ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi

    # enable auto-suggestions
    if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
        . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        #ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#717171"
        ZSH_AUTOSUGGEST_STRATEGY=(history completion)
        #ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)
    fi
fi
unset color_prompt force_color_prompt

# Terminal Title
DISABLE_AUTO_TITLE="true"
# Executed before each prompt
precmd() {
    #echo -ne "\033]0;$LOGNAME@$(hostname -s): $(pwd|cut -d "/" -f 4-100)\007"
    echo -ne "\033]0;$LOGNAME@$(hostname -s):$(pwd|sed "s|^$HOME|~|")\007"
}

# References:
# https://wiki.archlinux.org/title/zsh
# https://zsh.sourceforge.io/FAQ/zshfaq.html
# https://github.com/zsh-users/zsh/blob/master/Functions/Prompts/prompt_fade_setup
# https://github.com/zsh-users/zsh/blob/master/Functions/Prompts/prompt_special_chars
# https://www.compart.com/en/unicode/
# https://www.bash2zsh.com/zsh_refcard/refcard.pdf
# man zshbuiltins
