# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

function dark {
    gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
}
function light {
    gsettings set org.gnome.desktop.interface gtk-theme 'Yaru'
}

export EDITOR='nvim'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/lua-5.4.3/src/:$PATH"
export PATH="$HOME/bin/:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/yandex-cloud/bin"
export PATH="$PATH:$HOME/ycp/bin"


DOTFILES_PATH=$HOME/custom-configs
export PATH="$PATH:$DOTFILES_PATH/utilities"

alias sourcerc="source ~/.zshrc"

alias tfapp="terraform apply --auto-approve"
alias tfa="terraform apply"
alias kaf="kubectl apply -f "
alias kdf="kubectl delete -f "
export KUBECONFIG=$HOME/.kube/config

alias tma="tmuxinator start allrounder"
alias tmas="tmuxinator stop allrounder"
alias tmm="tmuxinator start md"
alias tmms="tmuxinator stop md"
alias tmy="tmuxinator start yandex"
alias tmys="tmuxinator stop yandex"

alias ast="arc status"
alias acmsg="arc commit -m"

alias glow="glow -w 100"

alias pysource="source ./env/bin/activate"

alias rgc="rg --hidden --files   | rg"
alias rgh="rg --hidden --files ~ | rg"
alias rgr="sudo rg --hidden --files / | rg"

alias ls="exa -la --icons"
alias lst="exa --tree --level=2 --long --icons"
# alias screenkey="/home/tarasov-egor/screenkey/screenkey -s small --mods-mode emacs --ignore Ctrl -g '1000x1000+100+100'"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^ ' _atuin_search_widget

eval "$(navi widget zsh)"

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '$HOME/yandex-cloud/path.bash.inc' ]; then source '$HOME/yandex-cloud/path.bash.inc'; fi
# The next line enables shell command completion for yc.
if [ -f '$HOME/yandex-cloud/completion.zsh.inc' ]; then source '$HOME/yandex-cloud/completion.zsh.inc'; fi
# The next line updates PATH for Yandex Cloud Private CLI.
if [ -f '$HOME/ycp/path.bash.inc' ]; then source '$HOME/ycp/path.bash.inc'; fi
# The next line updates PATH for Yandex Cloud YDB CLI.
if [ -f '$HOME/ydb/path.bash.inc' ]; then source '$HOME/ydb/path.bash.inc'; fi

PATH="$HOME/arcadia:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for Yandex Cloud YDB CLI.
if [ -f '/home/tarasov-egor/ydb/path.bash.inc' ]; then source '/home/tarasov-egor/ydb/path.bash.inc'; fi

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

xset r rate 150 30

# Needed so I can call 'nvim' from INSIDE nvim and not open an nvim inside nvim, uses nvr
alias nvim='if [[ -z "$NVIM" ]]; then XXX="nvim" && YYY="" else XXX="nvr" && YYY="-l" fi && $XXX $YYY'

