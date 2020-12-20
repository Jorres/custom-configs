## Nvim configuration 

Put the coc-settings.json into ~/.config/nvim/, or your other nvim config path 

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
