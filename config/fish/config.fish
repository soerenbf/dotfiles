set -x EDITOR nvim
set -x GOPATH ~/go

# PATH
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin

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

if status is-interactive
    if type -q zellij
        # Update the zellij tab name with the current process name or pwd.
        function zellij_tab_name_update_pre --on-event fish_preexec
            if set -q ZELLIJ
                set -l cmd_line (string split " " -- $argv)
                set -l process_name $cmd_line[1]
                if test -n "$process_name" -a "$process_name" != "z" -a "$process_name" != "cd"
                    if test "$process_name" = "v"
                        set process_name (string join " " "nvim" (prompt_pwd))
                    end
                    command nohup zellij action rename-tab $process_name >/dev/null 2>&1
                end
            end
        end

        function zellij_tab_name_update_post --on-event fish_postexec
            if set -q ZELLIJ
                set -l cmd_line (string split " " -- $argv)
                set -l process_name $cmd_line[1]
                if test "$process_name" = "z" -o "$process_name" = "cd" -o "$process_name" = "v"
                    command nohup zellij action rename-tab (prompt_pwd) >/dev/null 2>&1
                end
            end
        end
    end
end
