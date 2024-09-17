#!/usr/bin/env bash

AQUA='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

START_TIME_TO_CALCULATE=$(date)
if [ -d "bin" ]; then
    echo -e "${RED}Removing current bin directory...${NC}"
    rm -rf bin > /dev/null 2>&1
fi

echo -e "${AQUA}Downloading PHP binary...${NC}"
curl -s -L https://github.com/pmmp/PHP-Binaries/releases/download/php-8.2-latest/PHP-Linux-x86_64-PM5.tar.gz | tar -xz > /dev/null 2>&1

echo -e "${AQUA}Installing dependencies...${NC}"
/workspaces/PocketMine-MP-ng/bin/php7/bin/php /usr/local/bin/composer install --no-dev --classmap-authoritative > /dev/null 2>&1

if [ -f "PocketMine-MP.phar" ]; then
    echo -e "${RED}Renaming and moving current PocketMine-MP.phar...${NC}"
    OLD_VERSIOn_NAME=$(date +"%d-%m-%y")
    mv PocketMine-MP.phar old_builds/PocketMine-MP_${OLD_VERSIOn_NAME}.phar
fi

echo -e "${AQUA}Making new PocketMine-MP.phar...${NC}"
composer make-server > /dev/null 2>&1

# Calculate time, including milliseconds (ex: 4.543 seconds)
TIME_TAKE_TO_CALCULATE=$(($(date +%s%N) - $(date -d "$START_TIME_TO_CALCULATE" +%s%N)))
TIME_TAKE_TO_CALCULATE=$(echo "scale=3; $TIME_TAKE_TO_CALCULATE / 1000000000" | bc)
echo -e "${AQUA}PocketMine-MP.phar has been built in ${TIME_TAKE_TO_CALCULATE}s${NC}"