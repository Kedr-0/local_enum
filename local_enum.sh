#!/bin/bash
clear

# Colores
CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
RESET='\033[0m'

echo -e "${CYAN}"
echo "────────────────────────────────────────────"
echo "            LOCAL ENUM"
echo "     Local Linux Enumeration Tool"
echo "────────────────────────────────────────────"
echo -e "${RESET}"

echo -e "${YELLOW}  Author     : Kedr-0${RESET}"
echo -e "${YELLOW}  Scope      : Local Enumeration${RESET}"
echo -e "${YELLOW}  Start Time : $(date)${RESET}"

echo -e "${WHITE}────────────────────────────────────────────────────────────────────────────${RESET}"


echo -e "${CYAN}[+] Información del objetivo${RESET}"
echo -e "    ├─ Hostname : $(hostname)"
echo -e "    ├─ User     : $(whoami)"
echo -e "    ├─ UID      : $(id -u)"
echo -e "    ├─ Kernel   : $(uname -r)"
echo -e "    └─ OS       : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '\"')"

#ESCANEO
echo
echo -e "${GREEN}[+] Iniciando enumeración local...${RESET}"
sleep 1

echo -e "${RED}\nUsuarios Activos\n${RESET}"

grep -e '/bin/sh' -e '/bin/bash' -e '/bin/zsh' /etc/passwd | awk -F ':' '{print $1}'  | sed -n "$i"p

echo -e "${RED}\nBinarios SUID\n${RESET}"

find / -perm -4000 2>/dev/null

echo -e "${RED}\nCapabilities\n${RESET}"

getcap -r / 2>/dev/null

echo -e "${RED}\nTareas Cron\n${RESET}"

ls -la /etc/cron*
echo -e "\n"
tail -n6 /etc/crontab

echo -e "${RED}\nBuscando archivos especificos\n${RESET}"

find / -type f -name "*.conf" -o -name "*.env" -o -name "*.php" -name "*.sh" -name "*.py" 2>/dev/null |  grep -e "pass" -e "db" -e "api" -e "key"

echo -e "${RED}\nServicios activos\n${RESET}"

systemctl list-units --type=service --state=active | grep "active"
