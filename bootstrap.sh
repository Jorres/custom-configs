sudo apt-get update
sudo apt-get install -y vim stow git gnome-tweaks zsh

# install brave

# remap capslock to ctrl, in gnome-tweaks > keyboard and mouse > additional layout options

# generate new ssh key pair, add to github account
# initialize /home/username/.ssh/config, examples on the previous machine

sudo apt-get install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# reboot machine

# clone dotfiles repo

# this installs zsh vi mode plugin, it is already sourced in zshrc
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode

sudo apt-get install -y tmux

sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator
sudo apt-get install -y ruby-full
sudo gem install tmuxinator

# install telegram desktop from Ubuntu Software

# Install `nerdfont.ttf` from this repo by clicking on it

# hide dock
# search for `extensions` app in ubuntu, should be installed. Untick `Ubuntu dock`


# LSP servers:

# Install node.js, tweak version as required
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install tsserver
sudo npm install -g typescript typescript-language-server

sudo apt-get install font-manager
