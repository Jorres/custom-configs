sudo apt-get update
sudo apt-get install -y vim stow git gnome-tweaks zsh tmux ruby-full font-manager libusb-dev bat

# install brave

# remap capslock to ctrl: 
# gnome-tweaks > keyboard and mouse > additional layout options > Caps Lock behaviour

# generate new ssh key pair, add to github account
# initialize /home/username/.ssh/config, examples on the previous machine

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# reboot machine for console change to apply

# clone dotfiles repo, call `./install.sh`

# OPTIONALLY, if you like:
# this installs zsh vi mode plugin, it is already sourced in zshrc
# git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode


sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator
sudo gem install tmuxinator
# install tmux plugin manager, download something
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install telegram desktop from Ubuntu Software

# install `nerdfont.ttf` from this repo by clicking on it

# hide dock: search for `extensions` app in ubuntu, should be installed. Untick `Ubuntu dock`
# Optionally, disable alt-tab


# Install node.js, tweak version as required
#                                         VVVVVV version here
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install cool things from npm:
sudo npm install -g typescript typescript-language-server prettier # typewritten


# Install docker, kubectl and helm
# Docker is good via this link: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru
# Just google kubectl and helm

# Install ansible
# Install CopyQ
# Install K9s and Popeye, however they are available as stow binaries
# Install starship, zsh wrapper

wget -qO- https://zotero.retorque.re/file/apt-package-archive/install.sh | sudo bash
sudo apt update
sudo apt install -y zotero

# Install cpp language server
# `snap install ccls --classic`
# place .ccls file into the project root as a marker


# This installs cht.sh
# https://github.com/chubin/cheat.sh#installation
PATH_DIR="$HOME/bin"  # or another directory on your $PATH
mkdir -p "$PATH_DIR"
curl https://cht.sh/:cht.sh > "$PATH_DIR/cht.sh"
chmod +x "$PATH_DIR/cht.sh"

# For navi:
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git config --global credential.helper "cache --timeout=3600"

# Install https://github.com/grwlf/xkb-switch so that language in tmux status line works

python3 -m pip install libtmux --user

# This install atuin, do interactively  
# bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
# atuin import auto

# Installing a very clean, easy to use and good looking top alternative
sudo add-apt-repository ppa:bashtop-monitor/bashtop
sudo apt update
sudo apt install bashtop
