# Main action

Put nvim to ~/.config/nvim/

## Additional actions

### CCLS

`snap install ccls` --classic - installation of a c++ language server
place .ccls file into the directory with the following content

```
    g++
    %cpp -std=c++2a
    %h %hpp --include=Global.h
    -Iinc
    -DMACRO
```

Add these lines to a file invoked with :CocConfig

```
    "languageserver": {
        "ccls": {
            "command": "ccls",
            "args": ["--log-file=/tmp/ccls.log", "-v=1"],
            "filetypes": ["c", "cc", "cpp", "c++", "objc", "objcpp"],
            "rootPatterns": [".ccls", "compile_commands.json"],
            "initializationOptions": {
                "cache": {
                    "directory": "/tmp/ccls"
                },
                "client": {
                    "snippetSupport": true
                }
            }
        }
    }
```

Google further, if needed.
