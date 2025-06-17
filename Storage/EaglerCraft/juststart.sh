#!/bin/bash

# 1) Print the “downloading jar” banner
printf "\n ________________________________________________________\n| IF DOWNLOADING VANILLA JAR, IT MAY TAKE A FEW MINUTES. |\n|________________________________________________________|\n"

# 2) Finally exec Java on the real jar. Make sure ${SERVER_JARFILE} matches your actual jar name.
exec java -Xms128M -XX:MaxRAMPercentage=95.0 \
  -Dterminal.jline=false -Dterminal.ansi=true \
  -jar ${SERVER_JARFILE}
