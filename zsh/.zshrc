# zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

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

export EDITOR='nvim'

export PATH="$HOME/lua-5.4.3/src/:$PATH"
export PATH="$HOME/bin/:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/ycp/bin"
export PATH="$PATH:$HOME/work/nebius/kikimr-tools"
export PATH="$PATH:$HOME/nebo"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/work/nebius/ydbops/bin"
export PATH="$PATH:$HOME/hobbies/history-everywhere/"
export PATH="$PATH:$HOME/hobbies/jops/"
export PATH="$PATH:$HOME/work/nebo/"
export PATH="$HOME/.npm-global/bin:$PATH"

DOTFILES_PATH=$HOME/custom-configs
export PATH="$PATH:$DOTFILES_PATH/utilities"

alias sourcerc="source ~/.zshrc"

alias tfapp="terraform apply --auto-approve"
alias tfa="terraform apply"
alias tfp="terraform plan"
alias kaf="kubectl apply -f "
alias kdf="kubectl delete -f "
alias tsp="tsh --proxy=bastion.pa10.nebiusinfra.net:443 "

export KUBECONFIG=$HOME/.kube/config

alias ast="arc status"
alias ad="arc diff"
alias ads="arc diff --staged"
alias ap="arc push"
alias al="arc pull"
alias aa="arc add"
alias aco="arc checkout"
alias acmsg="arc commit -m"

alias rgh="rg --hidden --files ~ | rg"
alias rgr="sudo rg --hidden --files / | rg"

alias ls="exa -la --icons"
alias lst="exa --tree --level=2 --long --icons"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^ ' _atuin_search_widget

eval "$(navi widget zsh)"

PATH="$HOME/arcadia:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

xset r rate 150 30

# Needed so I can call 'nvim' from INSIDE nvim and not open an nvim inside nvim, uses nvr
alias nvim='if [[ -z "$NVIM" ]]; then XXX="nvim" && YYY="" else XXX="nvr" && YYY="-l" fi && $XXX $YYY'

alias nnn='nnn -e'
export NNN_BMS="c:~/custom-configs/;d:~/Downloads/;t:~/Downloads/Telegram Desktop/"
export NNN_PLUG='z:autojump;d:dragdrop'
export NNN_TMPFILE="$HOME/.config/nnn/.lastd"

n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

alias nnn='n'

export GTK_IM_MODULE='xim'
export QT_IM_MODULE='ibus'
export XMODIFIERS='@im=ibus'
export GLFW_IM_MODULE='ibus'

export PATH="$PATH:/home/jorres/work/nebius/ydbops"
export PATH="$PATH:/home/jorres/.local/bin"

# zprof

# The next line updates PATH for CLI.
if [ -f '/home/jorres/nebius-cloud/path.bash.inc' ]; then source '/home/jorres/nebius-cloud/path.bash.inc'; fi

# The next line enables shell command completion for ncp.
if [ -f '/home/jorres/nebius-cloud/completion.zsh.inc' ]; then source '/home/jorres/nebius-cloud/completion.zsh.inc'; fi

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/home/jorres/yandex-cloud/path.bash.inc' ]; then source '/home/jorres/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/jorres/yandex-cloud/completion.zsh.inc' ]; then source '/home/jorres/yandex-cloud/completion.zsh.inc'; fi



# The next line updates PATH for Nebius Private CLI.
if [ -f '/home/jorres/.config/newbius/path.bash.inc' ]; then source '/home/jorres/.config/newbius/path.bash.inc'; fi
# The next line enables shell command completion for Nebius Private CLI.
if [ -f '/home/jorres/.config/newbius/completion.zsh.inc' ]; then source '/home/jorres/.config/newbius/completion.zsh.inc'; fi

export GLFW_IM_MODULE=ibus kitty

# Custom completions
source $HOME/completions/_jops_k_completion.zsh

export ANTHROPIC_API_KEY=$(cat $HOME/anthropic_api_key)
