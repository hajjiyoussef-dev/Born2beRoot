#!/bin/bash

architecture=$(uname -a)
cup_physical=$(grep -c ^processor /proc/cpuinfo)
vcpu=$(nproc)
memory_usage=$(free -m | awk '/Mem:/ {printf "%d/%dMB (%.2f%%)", $3, $2, $3/$2 * 100}')
cpu_load=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 "%"}')
disk_usage=$(df -h / | awk '/\// {printf "%s/%s (%s)", $3, $2, $5}')
last_boot=$(who -b | awk '{print $3, $4}')
lvm_use=$(lsblk | grep -q "lvm" && echo "yes" || echo "no")
tcp_connections=$(ss -t | grep ESTAB | wc -l)
user_log=$(who | wc -l)
id_address=$(hostname -I | awk '{print $1}')
mac_address=$(ip link show | awk '/ether/ {print $2}')
sudo_cmd=$(grep -c "COMMAND" /var/log/sudo/sudo.log 2>/dev/null || echo "0")

wall "
#Architecture: $architecture
#CPU physical: $cup_physical
#vCPU: $vcpu
#Memory Usage: $memory_usage
#Disk Usage: $disk_usage
#CPU load: $cpu_load
#Last boot: $last_boot
#LVM use: $lvm_use
#Connections TCP: $tcp_connections
#User log: $user_log
#Network: IP $id_address ($mac_address)
#Sudo: $sudo_cmd cmd
"