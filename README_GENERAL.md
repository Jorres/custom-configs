## Nvim configuration 

### Info on 
[fuzzy finding](https://github.com/junegunn/fzf)
Wonderful plugin, replacement for denite with out-of-the-box configs ready. Requires a cool cli tool `bat`, 
it is like `cat` but on command line. Search for it to install on your system.

### Caps lock remapping

Use `gnome-tweaks-tool` to remap the Caps-Lock key with ctrl, it would be much easier to delete using `<C-w/h>`, and you do not use Caps-Lock anyway
It also helps to exit insert mode blazingly fast

### Prettier

Create `.prettierrc` in the root of the project.
To format your file, run `:Prettier` in vim command line.

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


Google further, if needed.

Run `stack install hspec-discover` for hie to see test directory.
You have to put the following in the `hie.yaml` file in the project root:
```
cradle:
  stack:
    - path: "./app/"
      component: "fresh-hw3-Jorres:exe:fresh-hw3-Jorres-exe"
    - path: "./src/"
      component: "fresh-hw3-Jorres:lib"
    - path: "./test/"
      component: "fresh-hw3-Jorres:test:fresh-hw3-Jorres-test"
    - path: "./Setup.hs"
      component: "Cabal"
```
Component names can be found with `stack ide targets`.

### C++ language server - CCLS

`snap install ccls --classic` - installation of a c++ language server
place .ccls file into the directory with the following content, google further

```
    g++
    %cpp -std=c++2a
    %h %hpp --include=Global.h
    -Iinc
    -DMACRO
```

### Kotlin language server

Clone language server implementation:
```
git clone https://github.com/fwcd/kotlin-language-server ~/.KotlinLanguageServer
```

Put this into `coc-settings.json`:
```
{
    "languageserver": {
        "kotlin": {
            "command": "~/.KotlinLanguageServer/server/build/install/server/bin/kotlin-language-server",
            "filetypes": ["kotlin"]
        }
    }
}
```