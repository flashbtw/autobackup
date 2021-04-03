#!/bin/bash
export CONFIG="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)/config.sh"
source $CONFIG
export LOGECHO="$CUSTOM_CMD_PATH/logecho.sh"
export LOGPRINTF="$CUSTOM_CMD_PATH/logprintf.sh"
export DATE_IN_FILE="$CUSTOM_CMD_PATH/date_in_file.sh"
source $LOGECHO
source $LOGPRINTF
source $DATE_IN_FILE

WHOAMI=`whoami`
#User Verification
if [ "$WHOAMI" != "root" ]; then
  echo "Script must be run as root or sudo-er"
  exit
fi

#catching error messages
errorcatcher

#checking if password file is empty
if [ "$PASSWORD" != "" ]
then
  echo "Password detected."
else
  echo "No Password detected. Exiting..."
  exit
fi

#Prompting for Password and Checking
read -s -p "Password: " TYPED_PASSWORD
if [ "$TYPED_PASSWORD" == "$PASSWORD"  ]
then
  {
  logprintf "\n "
  logprintf "\nServer restore will begin in a few sceonds. If you want to abort this action, press CTRL + C\n"
  /usr/bin/sleep 1
  logprintf "3...\n"
  /usr/bin/sleep 1
  logprintf "2...\n"
  /usr/bin/sleep 1
  logprintf "1...\n"
  /usr/bin/sleep 1
  logprintf "No Abortion detected. Restoring the server...\n"
  }
else
  logprintf "Authentication Failed.\n"
  exit
fi

#logging
bash $PFAD/logging.sh

#directory creation
#main.sh
bash $PFAD/directories/main.sh
