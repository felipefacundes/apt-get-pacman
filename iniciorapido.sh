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

# Try to detect if we are root
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

# Match any [options]
while :
do
    case "$1" in
        -n | --noconfirm)
            noconfirm=true
            shift
            ;;
        --) # End of all options
            shift
            break
            ;;
        -*)
            log_error "Unknown option: $1"
            break
            ;;
        *)  # No more options
            break
            ;;
    esac
done

log_info "Cloning pac repo to /tmp/pac"
git clone https://github.com/felipefacundes/apt-get-pacman.git /tmp/apt-get-pacman

log_info "Installing pac to /usr/bin/"
do_sudo install /tmp/apt-get-pacman/bin/apt-get /usr/bin/apt-get

if [ "$noconfirm" = true ]; then
    install_yay=true
else
    read -p "Use yay (y/n)?" -n 1 choice; echo
    case "$choice" in
        y|Y)
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
    log_info "Creating default ~/.yayrc"
    echo "BUILD_NOCONFIRM=1\nEDITFILES=0" > ~/.yayrc
    log_info "Installing yay"
    do_sudo apt-get update --noconfirm
    do_sudo apt-get install yay --noconfirm
fi
echo "Done!"
