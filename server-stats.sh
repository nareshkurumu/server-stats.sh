#!/bin/bash

# Function to display CPU usage
echo "===== CPU USAGE ====="
mpstat 1 1 | awk '/Average:/ {print "Total CPU Usage: " 100 - $NF "%"}'

echo "===== MEMORY USAGE ====="
free -h | awk '/Mem:/ {printf "Used: %s, Free: %s, Usage: %.2f%%\n", $3, $4, ($3/$2)*100}'

echo "===== DISK USAGE ====="
df -h / | awk 'NR==2 {printf "Used: %s, Free: %s, Usage: %s\n", $3, $4, $5}'

echo "===== TOP 5 PROCESSES BY CPU USAGE ====="
ps -eo pid,comm,%cpu --sort=-%cpu | head -6

echo "===== TOP 5 PROCESSES BY MEMORY USAGE ====="
ps -eo pid,comm,%mem --sort=-%mem | head -6

# Stretch goal

echo "===== SYSTEM INFORMATION ====="
echo "OS Version: $(lsb_release -d | awk -F'    ' '{print $2}')"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average: ' '{print $2}')"
echo "Logged in users: $(who | wc -l)"

echo "===== FAILED LOGIN ATTEMPTS ====="
sudo lastb | head -10
