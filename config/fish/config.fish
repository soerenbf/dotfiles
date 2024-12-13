set -gx EDITOR nvim
set -Ux fifc_editor nvim

alias v='nvim'

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

alias nv="nvim"
alias em="emacs"
alias lg="lazygit"

alias rustfmt="cargo +nightly-2023-04-01 fmt"
