# Main action

Place `nvim-config/*` to `~/.config/nvim/*`

## Additional actions

### CCLS

`snap install ccls --classic` - installation of a c++ language server
place .ccls file into the directory with the following content

```
    g++
    %cpp -std=c++2a
    %h %hpp --include=Global.h
    -Iinc
    -DMACRO
```

### Haskell

[Guide to language server](http://marco-lopes.com/articles/Vim-and-Haskell-in-2019/)

Put the coc-settings.json into ~/.config/nvim/. or elsewhere, google.

Google further, if needed.
