set -x EDITOR hx
set -x GOPATH ~/go
set -x KANATA_TRAY_CONFIG_DIR ~/.config/kanata-tray
set -x KANATA_TRAY_LOG_DIR ~/.config/kanata-tray

# PATH
fish_add_path ~/.local/bin
fish_add_path /usr/local/go/bin
fish_add_path $GOPATH/bin

# enable vi mode
set -g fish_key_bindings fish_vi_key_bindings

alias cc='concordium-client'
alias cct='concordium-client --grpc-ip grpc.testnet.concordium.com --secure'
alias ccm='concordium-client --grpc-ip grpc.mainnet.concordium.software --secure'

alias gc="git commit"
alias gcm="git commit -m"
alias gca="git commit -am"
alias gs="git status"
alias gcl="git clone --recurse-submodules"
alias gsw="git switch --recurse-submodules"
alias gsu="git submodule update --init --recursive"

alias v='nvim'
alias em="emacs"
alias lg="lazygit"

alias rustfmt="cargo +nightly-2023-04-01 fmt"

starship init fish | source

if test -f "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end

if status is-interactive
    if type -q zellij
        # Helper function to set Zellij tab name
        function set_zellij_tab_name
            set -l cmd_line (string split " " -- $argv)
            set -l process_name $cmd_line[1]

            if test "$process_name" = v
                set process_name (string join " " "nvim" (prompt_pwd))
            end

            command nohup zellij action rename-tab $process_name >/dev/null 2>&1
        end

        # Update the zellij tab name with the current process name or pwd.
        function zellij_tab_name_update_pre --on-event fish_preexec
            if set -q ZELLIJ
                set_zellij_tab_name
            end
        end

        function zellij_tab_name_update_post --on-event fish_postexec
            if set -q ZELLIJ
                command nohup zellij action rename-tab (prompt_pwd) >/dev/null 2>&1
            end
        end
    end
end
