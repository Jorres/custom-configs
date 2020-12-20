## Main action

Place `nvim-config/*` to `~/.config/nvim/*`

## Additional actions

### Caps lock remapping

Use `gnome-tweaks-tool` to remap the Caps-Lock key with ctrl, it would be much easier to delete using `<C-w/h>`, and you do not use Caps-Lock anyway
It also helps to exit insert mode blazingly fast

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
