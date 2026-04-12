#!/bin/bash

# Styling
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m'

echo -e "${MAGENTA}==========================================${NC}"
echo -e "${WHITE}    DOCKER SECURITY & RESOURCE AUDIT      ${NC}"
echo -e "${MAGENTA}==========================================${NC}"

# 1. Audit Container Resource Usage (Are containers eating too much?)
echo -e "\n${WHITE}[+] Auditing Resource Consumption...${NC}"
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# 2. Audit Image Vulnerabilities
echo -e "\n${WHITE}[+] Scanning Local Images...${NC}"
docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | head -n 10

# 3. Check for Root Privileges (Security risk check)
echo -e "\n${WHITE}[+] Checking Container Runtime Security...${NC}"
# This checks if any container is running in "privileged" mode (dangerous)
PRIVILEGED=$(docker inspect --format='{{.HostConfig.Privileged}}' $(docker ps -q) 2>/dev/null)
if [[ "$PRIVILEGED" == *"true"* ]]; then
    echo -e "⚠️  WARNING: Privileged container detected!"
else
    echo -e "Container Runtime: Secure ✅"
fi

echo -e "\n${MAGENTA}==========================================${NC}"
