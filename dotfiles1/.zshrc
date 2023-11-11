# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

fastfetch

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

alias vim=nvim
alias vim='nvim'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=always'
alias ip='ip -color=auto'
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -l'
alias pp='prettyping --nolegend'
alias dl="axel -4 -n4"
alias zshrc="${=EDITOR} ~/.zshrc"
alias nvimrc="${=EDITOR} ~/.config/nvim/init.lua"
alias dotfile="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias xz='xz -T $(nproc)'
alias ydl-audio="youtube-dl --cookies $HOME/.youtube-cookies.txt -f \"bestaudio/best\" -ciw -o \"%(title)s.%(ext)s\" -v --extract-audio --audio-quality 0 --audio-format m4a --add-metadata --embed-thumbnail"
# --embed-thumbnail 
alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias get_idf='. /opt/esp-idf/export.sh'
alias lg='lazygit'
alias vrecord="wl-screenrec --low-power off -f $HOME/Videos/ScreenRecords/$(date +%F-%H%M%S).mp4 --codec hevc"
alias C:='/mnt/OS'
alias D:='/mnt/Disk1'
alias F:='/mnt/Disk2'

# nvim plugins
alias nvim-plugins="nvim $HOME/.config/nvim/lua/plugins.lua"
alias date-iso='date +"%Y-%m-%dT%H:%M:%S%z"'



# Dependencies You Need for this Config
# zsh-syntax-highlighting - syntax highlighting for ZSH in standard repos
# autojump - jump to directories with j or jc for child or jo to open in file manager
# zsh-autosuggestions - Suggestions based on your history

# Initial Setup
# touch "$HOME/.cache/zshhistory
# Setup Alias in $HOME/zsh/aliasrc
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Custom Variables
EDITOR=nvim

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

ENABLE_CORRECTION="true"

plugins=(
  # zsh-vi-mode
  colorize
  fzf
  git
  k
  sudo
)

# Basic auto/tab complete:
autoload -U compinit
setopt autocd
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# Custom ZSH Binds
bindkey '^ ' autosuggest-accept
bindkey '\e[3~' delete-char

# Load ; should be last.
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
