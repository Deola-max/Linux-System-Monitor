#!/bin/bash

# --- The Server Watchman ---
# This script monitors system health

echo "--- SYSTEM HEALTH REPORT ($(date)) ---"

# 1. Check CPU Usage
CPU_LOAD=$(/usr/bin/top -bn1 | /usr/bin/grep "Cpu(s)" | /usr/bin/awk '{print $2 + $4}')
echo "CPU Usage: $CPU_LOAD%"

# 2. Check Memory (RAM)
MEM_FREE=$(/usr/bin/free -m | /usr/bin/awk '/Mem:/ { print $4 }')
echo "Free RAM: ${MEM_FREE}MB"

# 3. Check Disk Space
DISK_USAGE=$(/bin/df -h / | /usr/bin/awk 'NR==2 {print $5}')
echo "Disk Used: $DISK_USAGE"

# --- The "DevOps" Logic (The Alert) ---
if [ ${MEM_FREE} -lt 500 ]; then
    echo "⚠️  WARNING: RAM is running low! Less than 500MB left."
fi

echo "--------------------------------------"