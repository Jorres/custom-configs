_jk_completion() {
    if [[ $words[2] == "k" ]]; then
        local config_file="$HOME/hobbies/jops/config.yaml"

        local opts=($(yq e '.clusters | keys | .[]' "$config_file"))

        compadd -- "${opts[@]}"
    fi
}

compdef _jk_completion jops=k
