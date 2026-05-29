set -x EDITOR nvim
set -x GOPATH ~/go
set -x KANATA_TRAY_CONFIG_DIR ~/.config/kanata-tray
set -x KANATA_TRAY_LOG_DIR ~/.config/kanata-tray
set -x OPENSPEC_TELEMETRY 0

# PATH
fish_add_path ~/.local/bin
fish_add_path /usr/local/go/bin
fish_add_path $GOPATH/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.ghcup/bin
fish_add_path ~/.cabal/bin

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
        function zellij_ssh_target_from_command --argument-names cmd
            set -l cmd_line (string split " " -- $cmd)
            set -e cmd_line[1]

            set -l ssh_opts_with_value -b -c -D -E -e -F -I -i -J -L -l -m -O -o -p -Q -R -S -W -w
            set -l skip_next 0

            for token in $cmd_line
                if test $skip_next -eq 1
                    set skip_next 0
                    continue
                end

                if contains -- $token $ssh_opts_with_value
                    set skip_next 1
                    continue
                end

                if string match -qr '^-' -- $token
                    continue
                end

                echo $token
                return 0
            end

            return 1
        end

        # Helper function to set Zellij tab name for selected commands only
        function set_zellij_tab_name --argument-names cmd
            set -l cmd_line (string split " " -- $cmd)
            set -l process_name $cmd_line[1]

            switch $process_name
                case v
                    command nohup zellij action rename-tab (string join " " "nvim" (prompt_pwd)) >/dev/null 2>&1
                case ssh mosh
                    set -l ssh_target (zellij_ssh_target_from_command $cmd)
                    if test -n "$ssh_target"
                        command nohup zellij action rename-tab (string join " " "ssh" $ssh_target) >/dev/null 2>&1
                    end
            end
        end

        # Update the zellij tab name with the current process name or pwd.
        function zellij_tab_name_update_pre --on-event fish_preexec
            if set -q ZELLIJ
                set_zellij_tab_name $argv[1]
            end
        end

        function zellij_tab_name_update_post --on-event fish_postexec
            if set -q ZELLIJ
                command nohup zellij action rename-tab (prompt_pwd) >/dev/null 2>&1
            end
        end
    end
end
