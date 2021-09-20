## Nvim configuration 

Place `nvim-config/*` to `~/.config/nvim/*`

Install following requirements:
```
sudo apt install nodejs
sudo apt-get install ripgrep
pip3 install pynvim --upgrade
```
Create vim backup dir: (important, otherwise you won't be able to write things without !)
```
mkdir -p ~/.local/share/nvim/backup
sudo apt install nodejs
```

### If you use vim-deep-space (deprecated)

Highlight of matching parentheses

Go on to vim-deep-space.vim, search for `MatchParen` and replace its line with:
` call s:HL('MatchParen',                     s:pink,     s:gray1,         'bold') `
