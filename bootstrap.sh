sudo apt-get update
sudo apt-get install -y vim stow git gnome-tweaks zsh tmux ruby-full font-manager libusb-dev

# install brave

# remap capslock to ctrl: 
# gnome-tweaks > keyboard and mouse > additional layout options > Caps Lock behaviour

# generate new ssh key pair, add to github account
# initialize /home/username/.ssh/config, examples on the previous machine

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# reboot machine for console change to apply

# clone dotfiles repo, call `./install.sh`

# this installs zsh vi mode plugin, it is already sourced in zshrc
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode


sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator
sudo gem install tmuxinator
# install tmux plugin manager, download something
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install telegram desktop from Ubuntu Software

# install `nerdfont.ttf` from this repo by clicking on it

# hide dock: search for `extensions` app in ubuntu, should be installed. Untick `Ubuntu dock`


# Install node.js, tweak version as required
#                                         VVVVVV version here
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install cool things from npm:
sudo npm install -g typescript typescript-language-server typewritten prettier


# Install docker, kubectl and helm
# Docker is good via this link: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru
# Just google kubectl and helm

# Install ansible
# Install CopyQ
