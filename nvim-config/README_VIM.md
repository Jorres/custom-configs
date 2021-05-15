## Nvim configuration 

Place `nvim-config/*` to `~/.config/nvim/*`

Install following requirements for `Denite, Coc` etc. :
```
sudo apt install nodejs
sudo apt-get install ripgrep
pip3 install pynvim --upgrade
```
In order for denite to work install pip like in here:
https://linuxize.com/post/how-to-install-pip-on-ubuntu-20.04/
And then:
```
pip install msgpack
pip install neovim
```
And then in vim console:
```
:UpdateRemotePlugins 
```

Create vim backup dir: (important, otherwise you won't be able to write things without !)
```
mkdir -p ~/.local/share/nvim/backup
sudo apt install nodejs
```

Run this in vim console, coc extensions:
```
CocInstall coc-prettier coc-json coc-eslint coc-tsserver coc-css
```

### Highlight of matching parentheses

Go on to vim-deep-space.vim, search for `MatchParen` and replace its line with:
` call s:HL('MatchParen',                     s:pink,     s:gray1,         'bold') `
