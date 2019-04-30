#!/bin/bash

function log_info {
    echo "$(tput setaf 4)==> $1$(tput sgr0)" >&2
}
function log_warn {
    echo "$(tput setaf 3)WARNING: $1$(tput sgr0)" >&2
}
function log_error {
    echo "$(tput setaf 1)ERROR: $1$(tput sgr0)" >&2
}

# Detectar se é root
if [ "$(whoami)" != "root" ]; then
    use_sudo=true
fi
function do_sudo {
    if [ "$use_sudo" = true ]; then
        sudo $@
    else
        $@
    fi
}

# Opções
while :
do
    case "$1" in
        -n | --noconfirm)
            noconfirm=true
            shift
            ;;
        --) # Fim das opções
            shift
            break
            ;;
        -*)
            log_error "Opção vazia: $1"
            break
            ;;
        *)  # Sem mais opções
            break
            ;;
    esac
done

log_info "Clonando apt-get-pacman para /tmp/apt-get-pacman"
git clone https://github.com/felipefacundes/apt-get-pacman.git /tmp/apt-get-pacman

log_info "Instalando apt-get-pacman para /usr/bin/"
do_sudo install /tmp/apt-get-pacman/bin/apt-get /usr/bin/apt-get

if [ "$noconfirm" = true ]; then
    install_yay=true
else
    read -p "Vai usar o yay (s/n)?" -n 1 choice; echo
    case "$choice" in
        s|Y)
            install_yay=true
            ;;
        n|N )
            install_yay=false
            ;;
        *)
            log_error "invalid choice"
            exit 1
            ;;
    esac
fi
if [ "$install_yay" = true ]; then
    log_info "Criando configuração ~/.yayrc"
    echo "BUILD_NOCONFIRM=1\nEDITFILES=0" > ~/.yayrc
    log_info "Instalando yay"
    do_sudo apt-get update --noconfirm
    do_sudo apt-get install yay --noconfirm
fi
echo "Fim!"
echo "Entre no nosso grupo do Telegram:"
echo "https://t.me/winehq_linux"
