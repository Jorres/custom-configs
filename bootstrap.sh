sudo apt-get update 
sudo apt-get install -y vim stow git gnome-tweaks zsh tmux ruby-full font-manager libusb-dev bat net-tools gimp cpulimit iotop xclip
# Special treatment for some rust tools, bug workaround:
sudo apt install -y -o Dpkg::Options::="--force-overwrite" bat ripgrep

# Stuff for awesome wm to work
sudo apt-get install -y dmenu nitrogen alsa-utils xbacklight libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
# Do this to fix xbacklight:
https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder

# Install picom (needed for transparent borders)
git clone https://github.com/jonaburg/picom
cd picom
meson --buildtype=release . build
ninja -C build
# To install the binaries in /usr/local/bin (optional)
sudo ninja -C build install

# Install drag-n-drop dependency for nnn
sudo apt-get install libgtk-3-dev
git clone https://github.com/mwh/dragon.git
cd dragon
make
make install

# Clone misc widget repository
git clone https://github.com/streetturtle/awesome-wm-widgets.git ~/.config/awesome/awesome-wm-widgets
# Clone other widget repository
git clone https://github.com/pltanton/net_widgets.git ~/.config/awesome/net_widgets

# Install image-ascii-converter
echo 'deb [trusted=yes] https://apt.fury.io/ascii-image-converter/ /' | sudo tee /etc/apt/sources.list.d/ascii-image-converter.list
sudo apt update
sudo apt install -y ascii-image-converter
sudo rm -v /etc/apt/sources.list.d/ascii-image-converter.list

# install brave

# remap capslock to ctrl: 
# gnome-tweaks > keyboard and mouse > additional layout options > Caps Lock behaviour

# generate new ssh key pair, add to github account
# initialize /home/username/.ssh/config, examples on the previous machine

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# reboot machine for console change to apply

# clone custom-configs repo, call `./install.sh`

# OPTIONALLY, if you like:
# this installs zsh vi mode plugin. Don't forget to source zsh-vi-mode in zshrc
# git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode
git clone git@github.com:brokendisk/dune-quotes.git $ZSH/custom/plugins/dune-quotes
sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator
sudo gem install tmuxinator
# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir ~/tmux-logs
# Hit Prefix + I to install all the plugins

# install telegram desktop from Ubuntu Software

# install `nerdfont.ttf` from this repo by clicking on it

# hide dock: search for `extensions` app in ubuntu, should be installed. Untick `Ubuntu dock`
# Optionally, disable alt-tab


# Install node.js, tweak version as required
#                                         VVVVVV version here
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install cool things from npm:
sudo npm install -g typescript typescript-language-server prettier tldr
# typewritten

# Install docker, kubectl and helm
# Docker is good via this link: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru
# Just google kubectl and helm

# Install ansible
# Install CopyQ
# Install starship, zsh wrapper

# For navi:
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git config --global credential.helper "cache --timeout=3600"

# Install https://github.com/grwlf/xkb-switch so that language in tmux status line works
 
python3 -m pip install libtmux --user

# Anki
# Here's the manual no installing Anki
# https://docs.ankiweb.net/platform/linux/installing.html
python3 -m pip install markdown-anki-deck

# This install atuin, do interactively  
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

cp ./nosudo-for-jorres.copy-low-permissions ./nosudo-for-jorres
sudo chmod 440 /etc/sudoers.d/nosudo-for-jorres
sudo ln -s /etc/sudoers.d/nosudo-for-jorres $HOME/custom-configs/nosudo-for-jorres

# install `dust` utility, du alternative, as binary from github
# (should be in stow-bin binaries)

# Install golang (binary from site, or some outdated version in apt)
# Install gopls:
go install golang.org/x/tools/gopls@latest 
# Install k9s
go install github.com/derailed/k9s
# Install glow
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

# :MasonInstall bash-language-server dockerfile-language-server fixjson gopls kotlin-language-server lua-language-server prettier terraform-ls typescript-language-server
 
pip3 install neovim-remote


#### Trydactyl
# Install tridactyl itself:
https://github.com/tridactyl/tridactyl#installation
# Then native messenger:
curl -fsSl https://raw.githubusercontent.com/tridactyl/native_messenger/master/installers/install.sh -o /tmp/trinativeinstall.sh && sh /tmp/trinativeinstall.sh master
# Hide annoying mode indicator
:set modeindicator false



## Install
gcl https://github.com/pop-os/shell.git
cd sheet && make local-install
