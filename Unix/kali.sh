#!/usr/bin/env bash

# For use with Kali with OpenVAS installed.

# Installation:

#   #> cp kali_openvas.sh /usr/bin/update
#   #> chmod +x /usr/bin/update
#   #> update

# ===== Shouldn't have to change anything under this =====

BLUE='\033[1;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

printf "${BLUE}System Updater${NC}\n\n"
if [ -z ${SUDO_USER+x} ] || [ $(id -u) != 0 ]; then
    printf "${GREEN}[+] Checking for root:${NC}\n"
fi
if [[ $(sudo id -u) == 0 ]]; then
    printf "${GREEN}[+] Checking for root:${NC}"
    printf " OK\n"
    printf "${GREEN}[+] Updating Kali:${NC}\n"
    sudo apt-get update | sed 's/^/    /'
    sudo apt-get dist-upgrade -y | sed 's/^/    /'
    sudo apt-get autoremove -y | sed 's/^/    /'
    sudo apt-get autoclean -y | sed 's/^/    /'
    sudo apt-get clean -y | sed 's/^/    /'

printf "${YELLOW}\n[!] Would you like to reboot? [y|N] ${NC}"
read -r response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]]; then
    sudo reboot
fi
else
    printf "\n${RED}[!] YOU MUST BE ROOT!${NC}\n"
fi
