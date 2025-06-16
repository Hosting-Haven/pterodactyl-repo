#!/bin/bash
set -e

JARFILE="${SERVER_JARFILE:-paperclip.jar}"
SERVER_PORT="${SERVER_PORT:-25565}"
QUERY_PORT=$((SERVER_PORT - 1000))

# -- Display a banner --
echo -e "\e[1;34m==== Hosting Haven EaglerCraft Startup ====\e[0m"
echo -e "\e[36mPreparing to launch your server...\e[0m"

# -- Warn if jar is missing --
if [ ! -f "$JARFILE" ]; then
    echo -e "\e[1;33m[!]\e[0m Server JAR not found: \e[31m$JARFILE\e[0m"
    echo -e "\e[1;33m[~]\e[0m If this is the first launch, it may take a few minutes to download and prepare the server..."
fi

# -- Setup server.properties if needed --
if [ -f server.properties ]; then
    echo -e "\e[1;34m[~]\e[0m Configuring \e[33mquery.port=$QUERY_PORT\e[0m..."
    sed -i "s/^query.port=.*/query.port=$QUERY_PORT/" server.properties || echo "query.port=$QUERY_PORT" >> server.properties
else
    echo -e "\e[1;33m[!]\e[0m server.properties not found — skipping query port config."
fi

# -- Run the server --
java -Xms${STARTUP_MEMORY:-128M} -Xmx${SERVER_MEMORY:-512M} -jar "$JARFILE" nogui
