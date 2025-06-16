#!/bin/bash
set -e

JARFILE="${SERVER_JARFILE:-paperclip.jar}"
SERVER_PORT="${SERVER_PORT:-25565}"
QUERY_PORT=$((SERVER_PORT - 1000))

echo -e "\e[1;34m==== Hosting Haven EaglerCraft Startup ====\e[0m"
echo -e "\e[36mPreparing to launch your server...\e[0m"

if [ ! -f "$JARFILE" ]; then
    echo -e "\e[1;33m[!]\e[0m Server JAR not found: \e[31m$JARFILE\e[0m"
    echo -e "\e[1;33m[~]\e[0m If this is the first launch, it may take a few minutes to download and prepare the server..."
fi

# -- Fix the query-port setting --
if [ -f server.properties ]; then
    echo -e "\e[1;34m[~]\e[0m Setting \e[33mquery-port=$QUERY_PORT\e[0m..."
    if grep -q "^query-port=" server.properties; then
        sed -i "s/^query-port=.*/query-port=$QUERY_PORT/" server.properties
    else
        echo "query-port=$QUERY_PORT" >> server.properties
    fi
else
    echo -e "\e[1;33m[!]\e[0m server.properties not found — skipping query-port config."
fi

# -- Start the server --
echo -e "\e[1;32m[✓]\e[0m Launching server with memory: ${STARTUP_MEMORY:-128M} - ${SERVER_MEMORY:-512M}"
java -Xms${STARTUP_MEMORY:-128M} -Xmx${SERVER_MEMORY:-512M} -jar "$JARFILE" nogui
