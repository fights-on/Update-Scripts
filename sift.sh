#!/usr/bin/env bash

# For use with SANS Investigative Forensics Toolkit.

# Installation:

#   #> cp sift.sh /usr/bin/update
#   #> chmod +x /usr/bin/update
#   #> update

# ===== Shouldn't have to change anything under this =====

BLUE='\033[1;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

printf "${BLUE}System Updater${NC}\n\n"
printf "${GREEN}[+] Checking for root:${NC}"
if [ $(sudo id -u) = 0 ]; then
    printf "${GREEN} OK${NC}\n"
    printf "${GREEN}[+] Updating SIFT:${NC}\n"
    sudo sift update | sed 's/^/    /'

printf "${YELLOW}\n[!] Would you like to reboot? [y|N] ${NC}"
read -r response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]]; then
    sudo reboot
fi
else
    printf "\n${RED}[!] YOU MUST BE ROOT!${NC}\n"
fi