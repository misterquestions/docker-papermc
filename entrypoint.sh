#!/bin/bash

# Move to a working directory
if [ ! -e "server" ]; then
  mkdir server
fi

cd server

# Ensure we've all the required variables otherwise throw errors (for non optional ones)
PAPER_BUILD=${PAPER_BUILD:-latest}
MINECRAFT_MIN_RAM=${MINECRAFT_MIN_RAM:-128M}
MINECRAFT_MAX_RAM=${MINECRAFT_MAX_RAM:-2G}
MINECRAFT_RESTART_TIME=5

if [ -z "${MINECRAFT_SERVER_TYPE}" ]; then
  echo "MINECRAFT_SERVER_TYPE env variable is missing"
  exit 1
fi

if [ -z "${MINECRAFT_VERSION}" ]; then
  echo "MINECRAFT_VERSION env variable is missing"
  exit 1
fi

# Perform initial setup
JAR_NAME="papermc-${MINECRAFT_VERSION}-${PAPER_BUILD}.jar"

if [ ! -e ${JAR_NAME} ]; then
  wget "https://papermc.io/api/v1/${MINECRAFT_SERVER_TYPE}/${MINECRAFT_VERSION}/${PAPER_BUILD}/download" -O ${JAR_NAME}

  if [[ "${MINECRAFT_SERVER_TYPE}" == "paper" && ! -e eula.txt ]]; then
    echo "Server hasn't been started ever, accepting eula..."
    java -jar ${JAR_NAME}
    sed -i 's/eula=false/eula=true/g' eula.txt
  fi
fi

# Actually start the server
while [ true ]; do
  # clear
  echo "Server startup in progress..."
  echo "Type: ${MINECRAFT_SERVER_TYPE}"
  echo "Version: ${MINECRAFT_VERSION} (${PAPER_BUILD})"
  echo "Min. RAM: ${MINECRAFT_MIN_RAM} || Max. RAM: ${MINECRAFT_MAX_RAM}"
  printf "Optional arguments: ${MINECRAFT_JAVA_ARGS:-none}\n"
  java -server -Xms${MINECRAFT_MIN_RAM} -Xmx${MINECRAFT_MAX_RAM} ${MINECRAFT_JAVA_ARGS} -jar ${JAR_NAME} nogui

  # Write to a log file the exit code from the server
  if [ ! -e "server_exit_codes.log" ]; then
    touch "server_exit_codes.log"
  fi

  echo "[$(date +"%d.%m.%Y %T")] Server exited with code $?" >> server_exit_codes.log

  # Ask if we want to prevent automatic restart
  echo "Press enter to prevent the server from restarting, otherwise wait ${MINECRAFT_RESTART_TIME} seconds..."
  read -t ${MINECRAFT_RESTART_TIME} input

  if [ $? == 0 ]; then
    break
  fi
done