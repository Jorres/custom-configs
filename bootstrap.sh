## Do this all from regular ubuntu, and hopefully everything will work after you relogin to awesome

sudo apt-get update 
sudo apt-get install -y vim-gtk3 stow git gnome-tweaks zsh tmux ruby-full font-manager libusb-dev bat net-tools gimp cpulimit iotop xclip easytag xautomation build-essential feh simplescreenrecorder libfuse2 fuse curl copyq copyq-plugins mplayer gnome-control-center

git clone https://github.com/Jorres/dotfiles ~/custom-configs

# do `stow` invocations from 
~/custom-configs/install.sh

# for convenience so that you can copy from vim right away:
echo 'set clipboard=unnamedplus' >> /home/$USER/.vimrc
echo 'set number' >> /home/$USER/.vimrc
echo 'set relativenumber' >> /home/$USER/.vimrc

# Special treatment for some rust tools, bug workaround:
sudo apt install -y -o Dpkg::Options::="--force-overwrite" ripgrep

# generate new ssh key pair, add to github account
# initialize /home/username/.ssh/config, take examples on the previous machine
# 
# 

mkdir ~/hobbies
mkdir ~/hobbies/plugins
git clone git@github.com:Jorres/showmethat.nvim.git ~/hobbies/plugins/showmethat.nvim

## Install neovim
# get the appimage from github
# extract the appimage (snippet on github, next to asset download)
# put the binary into path, for example `sudo mv nvim.appimage /usr/local/bin/nvim`

# Do this to fix xbacklight:
https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder

# This will be installed along with stow-bin stuff. But in case something breaks, here is how to reinstall dragon for nnn:
	# Install drag-n-drop dependency for nnn
	# sudo apt-get install libgtk-3-dev
	# git clone https://github.com/mwh/dragon.git
	# cd dragon
	# make
	# make install

sudo snap install firefox telegram-desktop vlc skype discord

# Download zoom deb from official site, and then 
# sudo apt install ./zoom_amd64.deb

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# reboot machine for console change to apply

# OPTIONALLY, if you like:
# this installs zsh vi mode plugin. Add zsh-vi-mode to .zshrc to list of plugins
# git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode

# Make caps-lock act as ctrl
# Launch 'tweaks', 'keyboard and mouse', 'additional layout options', 'caps lock behaviour', 'additional ctrl'

# Install kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# The following chunk adds an icon of Kitty to desktop app menus. Works on Ubuntu!
# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
# your system-wide PATH)
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop


# At this point, you should have kitty and launch kitty. 

# Kitty should fail with a lot of not found programs, nvim must not launch with a whole bunch of errors, nerdfont characters should be off
# but you still should be comfortably able to open simple `vim` in kitty.

# install `nerdfont.ttf` from this repo by clicking on it

# Install node.js following this: https://github.com/nodesource/distributions#installation-instructions
# Install cool things from npm:
sudo npm install -g typescript typescript-language-server prettier tldr

# Install docker, kubectl and helm
# Docker is good via this link: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru
# Just google kubectl and helm

# Install starship, zsh wrapper
curl -sS https://starship.rs/install.sh | sh

# For navi:
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git config --global credential.helper "cache --timeout=3600"

# Anki
# Here's the manual no installing Anki
# https://docs.ankiweb.net/platform/linux/installing.html
python3 -m pip install markdown-anki-deck

# This install atuin, do this interactively
# bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
# atuin import auto
# Feed all kinds of history into it, backups, whatever

# Installing a very clean, easy to use and good looking top alternative
sudo add-apt-repository ppa:bashtop-monitor/bashtop
sudo apt update
sudo apt install bashtop

sudo snap install exercism
exercism configure --token=f9e912f4-334c-4b73-9566-6c57d33002f5

# install `dust` utility:
curl https://github.com/bootandy/dust/releases/download/v0.9.0/du-dust_0.9.0-1_amd64.deb -LO
sudo dpkg -i ./du-dust_0.9.0-1_amd64.deb
rm ./du-dust_0.9.0-1_amd64.deb

# Install golang (binary from site, or some outdated version in apt)
# Install any go modules that you need like this:
go install github.com/charmbracelet/glow@latest

# Setup Moonlander tooling
#####
sudo touch /etc/udev/rules.d/50-zsa.rules
>> # Rules for Oryx web flashing and live training
>> KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
>> KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"
>> 
>> # Legacy rules for live training over webusb (Not needed for firmware v21+)
>>   # Rule for all ZSA keyboards
>>   SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
>>   # Rule for the Moonlander
>>   SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
>>   # Rule for the Ergodox EZ
>>   SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
>>   # Rule for the Planck EZ
>>   SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"
>> 
>> # Wally Flashing rules for the Ergodox EZ
>> ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
>> ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
>> SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
>> KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
>> 
>> # Wally Flashing rules for the Moonlander and Planck EZ
>> SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", \
>>     MODE:="0666", \
>>     SYMLINK+="stm32_dfu"

sudo groupadd plugdev
sudo usermod -aG plugdev $USER

#### Neovim

# :MasonInstall fixjson prettier
 
pip3 install neovim-remote

# Nebius specific
echo 'Session.vim' >> ~/.arcignore
echo 'jorres_patches' >> ~/.arcignore

# How to setup neovim properly 

# 1. open neovim, click "enter" until errors stop
# 2. invoke `:PackerInstall` and pray
# 3. dance a little bit with vim-highlighter, grep `abc.txt` in my configs

# Setup keyboard repeat rate
# use this link: https://askubuntu.com/questions/846030/how-to-set-keyboard-repeat-delay-and-speed-in-ubuntu-gnome-16-10
# OR search for 'typing' or 'universal access' or 'repeat keys' section and adjust the sliders here
# OR just blindly apply the following:
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30
gsettings set org.gnome.desktop.peripherals.keyboard delay 150

# Setup tailscale at Nebius
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --accept-routes

# Disable ubuntu dock
gnome-extensions disable ubuntu-dock@ubuntu.com

# Tmux 
# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir ~/tmux-logs

sudo apt install python3-pip
python3 -m pip install libtmux --user

# Launch tmux
# Hit Prefix + I to install all the plugins

# Restore your previous resurrect data
# https://github.com/search?q=repo%3Atmux-plugins%2Ftmux-resurrect+default_resurrect_dir&type=code
#
# 'Prefix + Ctrl+R' | 'Prefix + R' restore resurrects and reload tmux.


# Japanese input
# Just execute precisely this link: https://help.ubuntu.com/community/JapaneseInput
# And everything will work even in a terminal.


# Flameshot
sudo apt install flameshot
