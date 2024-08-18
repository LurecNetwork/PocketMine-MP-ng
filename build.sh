#!/usr/bin/env bash

AQUA='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

if [ -d "bin" ]; then
    echo -e "${RED}Removing current bin directory...${NC}"
    rm -rf bin > /dev/null 2>&1
fi

echo -e "${AQUA}Downloading PHP binary...${NC}"
curl -s -L https://github.com/pmmp/PHP-Binaries/releases/download/php-8.2-latest/PHP-Linux-x86_64-PM5.tar.gz | tar -xz > /dev/null 2>&1

echo -e "${AQUA}Installing dependencies...${NC}"
/workspaces/PocketMine-MP-ng/bin/php7/bin/php /usr/local/bin/composer install > /dev/null 2>&1

if [ -f "PocketMine-MP.phar" ]; then
    echo -e "${RED}Removing current PocketMine-MP.phar...${NC}"
    rm -f PocketMine-MP.phar > /dev/null 2>&1
fi

echo -e "${AQUA}Making new PocketMine-MP.phar...${NC}"
composer make-server > /dev/null 2>&1

echo -e "${AQUA}The new PocketMine-MP.phar has been created!${NC}"