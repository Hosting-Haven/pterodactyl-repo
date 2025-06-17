#!/bin/bash
# 1) Calculate the query port from SERVER_PORT
QUERY_PORT=$(( SERVER_PORT ))

# 2) Update or append query_port in server.properties
if grep -q '^query_port=' server.properties; then
  sed -i "s/^query_port=.*/query_port=${QUERY_PORT}/" server.properties
else
  echo "query_port=${QUERY_PORT}" >> server.properties
fi

# 3) Print the “downloading jar” banner
printf "\n ________________________________________________________\n| IF DOWNLOADING VANILLA JAR, IT MAY TAKE A FEW MINUTES. |\n|________________________________________________________|\n"

# 4) Finally exec Java on the real jar. Make sure ${SERVER_JARFILE} matches your actual jar name.
exec java -Xms128M -XX:MaxRAMPercentage=95.0 \
  -Dterminal.jline=false -Dterminal.ansi=true \
  -jar ${SERVER_JARFILE}
