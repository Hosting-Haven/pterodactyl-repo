#!/bin/bash
set -e

SERVER_PORT="${SERVER_PORT}"  # Provided by Pterodactyl
QUERY_PORT=$((SERVER_PORT - 1000))

echo -e "\e[1;34m==== Hosting Haven EaglerCraft Startup ====\e[0m"
echo -e "\e[36mPreparing to launch your server on port $SERVER_PORT...\e[0m"

# -- Warn if jar is missing --
if [ ! -f "$JARFILE" ]; then
    echo -e "\e[1;33m[!]\e[0m Server JAR not found: \e[31m$JARFILE\e[0m"
    echo -e "\e[1;33m[~]\e[0m If this is the first launch, it may take a few minutes to download and prepare the server..."
fi

# -- Set query-port in server.properties --
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

# -- Start server --
java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar {{SERVER_JARFILE}}
