#!/bin/bash

#User Verification
WHOAMI=`whoami`

if [ "$WHOAMI" != "root" ]; then
  echo "Script must be run as root or sudo-er"
  exit
fi

#Password Reading
PASSWORD=`/usr/bin/cat /home/flashzboi/autobackup/pwd.password 2>>$ERROR_LOG`
#Path of Script
PFAD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
#Path of Error-Log-File
ERROR_LOG="$PFAD/log/errors.txt"
#Path of Log-File
LOG="$PFAD/log/log.txt"

#custom commands for logging
logecho()
(
    echo "$@"
    echo "$@" >>$LOG
)

logprintf()
(
    printf "$@"
    printf "$@" >>$LOG
)

#removing old logs
/usr/bin/rm $ERROR_LOG 2>>/dev/null
/usr/bin/rm $LOG 2>>/dev/null

#catching error messages
trap 'catch $? $LINENO' ERR
catch() {
  echo "Error occured in Line $2: For more information look in errors.txt file in log directory"
}

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
  logprintf "\nServer restore will begin in a few sceonds. If you want to abort this action, press CTRL + C\n"
  {
  /usr/bin/sleep 1
  logprintf "3...\n"
  /usr/bin/sleep 1
  logprintf "2...\n"
  /usr/bin/sleep 1
  logprintf "1...\n"
  /usr/bin/sleep 1
  logprintf "No Abortion detected. Restoring the server...\n"
  } 2>>$ERROR_LOG
else
  logprintf "Authentication Failed.\n"
  exit
fi

#checking if directorys already exist
#creating the main home directory
SERVER_DIR="/home/mc"
SERVER_DIR_TEST=`/usr/bin/ls $SERVER_DIR`

catch() {
  echo "Error occured in Line $2: For more information look in errors.txt file in log directory"
}

if [ "$SERVER_DIR_TEST" == "" ]; then
  {
  /usr/bin/mkdir /home/mc/
  /usr/bin/touch /home/mc/initial.indicator
  } 2>>$ERROR_LOG
  SERVER_DIR_TEST2=`/usr/bin/ls $SERVER_DIR 2>>/dev/null`

  if [ "$SERVER_DIR_TEST2" == "" ]; then
    logecho "Home Directory can not be created"
  else
    logecho "Home Directory successfully created"
  fi

else
  logecho "Home Directory already exists!"
fi
