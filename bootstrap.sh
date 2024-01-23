## Do this all from regular ubuntu, and hopefully everything will work after you relogin to awesome

sudo apt-get update 
sudo apt-get install -y vim stow git gnome-tweaks zsh tmux ruby-full font-manager libusb-dev bat net-tools gimp cpulimit iotop xclip easytag xautomation
# Special treatment for some rust tools, bug workaround:
sudo apt install -y -o Dpkg::Options::="--force-overwrite" bat ripgrep

mkdir ~/hobbies
mkdir ~/hobbies/plugins
git clone git@github.com:Jorres/showmethat.nvim.git ~/hobbies/plugins/showmethat.nvim


# Do this to fix xbacklight:
https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder

# Install drag-n-drop dependency for nnn
sudo apt-get install libgtk-3-dev
git clone https://github.com/mwh/dragon.git
cd dragon
make
make install

# Install nnn (build from source, sorry)
# no instruction here, just search

git clone https://github.com/Jorres/dotfiles ~/custom-configs

# Install image-ascii-converter
echo 'deb [trusted=yes] https://apt.fury.io/ascii-image-converter/ /' | sudo tee /etc/apt/sources.list.d/ascii-image-converter.list
sudo apt update
sudo apt install -y ascii-image-converter
sudo rm -v /etc/apt/sources.list.d/ascii-image-converter.list

# do `stow` invocations from ~/custom-configs/install.sh

# install brave | firefox or whatever floats your boat

# generate new ssh key pair, add to github account
# initialize /home/username/.ssh/config, take examples on the previous machine

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# reboot machine for console change to apply

# OPTIONALLY, if you like:
# this installs zsh vi mode plugin. Add zsh-vi-mode to .zshrc to list of plugins
# git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode

sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator
sudo gem install tmuxinator
# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir ~/tmux-logs
# Hit Prefix + I to install all the plugins

sudo snap install telegram-desktop

# install `nerdfont.ttf` from this repo by clicking on it

# Install node.js following this: https://github.com/nodesource/distributions#installation-instructions

# Install cool things from npm:
sudo npm install -g typescript typescript-language-server prettier tldr

# Install docker, kubectl and helm
# Docker is good via this link: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru
# Just google kubectl and helm

# Install CopyQ
# Install starship, zsh wrapper

# For navi:
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git config --global credential.helper "cache --timeout=3600"

python3 -m pip install libtmux --user

# Anki
# Here's the manual no installing Anki
# https://docs.ankiweb.net/platform/linux/installing.html
python3 -m pip install markdown-anki-deck

# This install atuin, do this interactively
# bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)
# atuin import auto

# Installing a very clean, easy to use and good looking top alternative
sudo add-apt-repository ppa:bashtop-monitor/bashtop
sudo apt update
sudo apt install bashtop

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

sudo snap install exercism
exercism configure --token=f9e912f4-334c-4b73-9566-6c57d33002f5

# install `dust` utility:
curl -LO dust.deb https://github.com/bootandy/dust/releases/download/v0.8.4/du-dust_0.8.4_amd64.deb
dpkg -i du-dust_0.8.4_amd64.deb
rm ./du-dust_0.8.4_amd64.deb

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
#

sudo groupadd plugdev
sudo usermod -aG plugdev $USER
#####

sudo cp ./stow-bin/bin/rg /usr/local/bin

#### Neovim

# :MasonInstall fixjson prettier
 
pip3 install neovim-remote

# Install ibus
sudo apt-get install fcitx-mozc ibus-mozc mozc-data mozc-server mozc-utils-gui
# Open a tray application (or run `ibus-setup`) and make sure `Advanced/Use system keyboard layout` is set
# Make sure you have ru, en, jp locales uncommented in /etc/locales.gen
# Run `locale-gen` afterwards

# Yandex specific

echo 'Session.vim' > ~/.arcignore
