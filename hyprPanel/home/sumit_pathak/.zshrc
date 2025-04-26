# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

fastfetch

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

export SUDO_PROMPT="$fg[white]Deploying $fg[red]root access for %u $fg[blue]password:󰌾 $fg[white]"


#  ┓ ┏┏┓┳┏┳┓┳┳┓┏┓  ┳┓┏┓┏┳┓┏┓
#  ┃┃┃┣┫┃ ┃ ┃┃┃┃┓  ┃┃┃┃ ┃ ┗┓
#  ┗┻┛┛┗┻ ┻ ┻┛┗┗┛  ┻┛┗┛ ┻ ┗┛
#                           
#expand-or-complete-with-dots() {
#  echo -n "\e[31m…\e[0m"
#  zle expand-or-complete
#  zle redisplay
#}

#zle -N expand-or-complete-with-dots
#bindkey "^I" expand-or-complete-with-dots

# Custom Variables
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="zen-browser"

# Home cleanup
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Spicetify
export PATH="$PATH:$HOME/.spicetify"

# History in cache directory:
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/zsh_history
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt interactive_comments # Interactive comments
setopt prompt_subst         # enable command substitution in prompt
setopt menu_complete        # Automatically highlight first element of completion menu
setopt list_packed	    # The completion menu takes less space.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt complete_in_word     # Complete from both ends of a word.
setopt autocd

ENABLE_CORRECTION="true"

# Basic auto/tab complete:
autoload -Uz compinit && compinit
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=0\;33'
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zmodload zsh/complist
_comp_options+=(globdots)               # Include hidden files.
zinit cdreplay -q

# Custom ZSH Binds
function backward-kill() {
  local WORDCHARS=${WORDCHARS//[\/._-]/}
  zle backward-kill-word
}
zle -N backward-kill

function kill-word-special() {
  local WORDCHARS=${WORDCHARS//[\/._-]/}
  zle kill-word
}
zle -N kill-word-special

function forward-word-special() {
  local WORDCHARS=${WORDCHARS//[\/._-]/}
  zle forward-word
}
zle -N forward-word-special

function backward-word-special() {
  local WORDCHARS=${WORDCHARS//[\/._-]/}
  zle backward-word
}
zle -N backward-word-special

#use kitty +kitten show_key
bindkey '^ ' autosuggest-accept
bindkey '\e[1;5A' history-search-backward
bindkey '\e[1;5B' history-search-forward
bindkey '\e[3~' delete-char
bindkey '\e[3;5~' kill-word-special
bindkey '\e[1;5D' backward-word-special
bindkey '\e[1;5C' forward-word-special
bindkey '^W' backward-kill

#bindkey -v
#export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
#function zle-keymap-select () {
#    case $KEYMAP in
#        vicmd) echo -ne '\e[1 q';;      # block
#        viins|main) echo -ne '\e[5 q';; # beam
#    esac
#}
#zle -N zle-keymap-select
#zle-line-init() {
#    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
#    echo -ne "\e[5 q"
#}
#zle -N zle-line-init
#echo -ne '\e[5 q' # Use beam shape cursor on startup.
#preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Basic binds deleting char both in normal or vi mode
#bindkey -v '^?' backward-delete-char

# Edit line in vim with ctrl-e:
#autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line

# Vicmd specific binds
#bindkey -M vicmd '^e' edit-command-line
#bindkey -M vicmd '^?' vi-delete-char
#bindkey -M visual '^?' vi-delete-char


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -f ~/.config/zsh/.aliasrc ] && source ~/.config/zsh/.aliasrc

export PATH="$PATH:/home/sumit_pathak/.local/bin"
export PATH=$HOME/.config/rofi/scripts:$PATH
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
