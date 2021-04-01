#!/bin/bash

#User Verification
WHOAMI=`whoami`

if [ "$WHOAMI" != "root" ]; then
  echo "Script must be run as root or sudo-er"
  exit
fi

#Path of Script
PFAD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
#Path of Error-Log-File
ERRORLOG="$PFAD/log/errors.txt"
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
/usr/bin/rm $ERRORLOG 2>>/dev/null
/usr/bin/rm $LOG 2>>/dev/null

#catching error messages
trap 'catch $? $LINENO' ERR
catch() {
  echo "Error occured in Line $2: For more information look in errors.txt file in log directory"
}

#Password Reading
PASSWORD=`/usr/bin/cat /home/flashzboi/autobackup/pwd.password 2>>$ERRORLOG`

#checking if password file is empty
if [ "$PASSWORD" != "" ]
then
  echo "Password detected."
else
  echo "No Password detected. Exiting..."
  exit
fi

#Prompting for Password and Checking
read -s -p "Password: " MYPASSWORD
if [ "$MYPASSWORD" == "$PASSWORD"  ]
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
  } 2>>$ERRORLOG
else
  logprintf "Authentication Failed.\n"
  exit
fi

#checking if directorys already exist
#creating the main home directory
SERVERDIR="/home/mc"
SERVERDIRTEST=`/usr/bin/ls $SERVERDIR`

catch() {
  echo "Error occured in Line $2: For more information look in errors.txt file in log directory"
}

if [ "$SERVERDIRTEST" == "" ]; then
  {
  /usr/bin/mkdir /home/mc/
  /usr/bin/touch /home/mc/initial.indicator
  } 2>>$ERRORLOG
  SERVERDIRTEST2=`/usr/bin/ls $SERVERDIR 2>>/dev/null`

  if [ "$SERVERDIRTEST2" == "" ]; then
    logecho "Home Directory can not be created"
  else
    logecho "Home Directory successfully created"
  fi

else
  logecho "Home Directory already exists!"
fi
