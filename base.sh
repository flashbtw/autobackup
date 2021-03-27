#!/bin/bash

WHOAMI=`whoami`

if [ "$WHOAMI" != "root" ]; then
  echo "Script must be run as root or sudo-er"
  exit
fi

PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
ERRORLOG="$PATH/log/errors.txt"
LOG="$PATH/log/log.txt"

#some custom commands
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
trap 'clean' ERR

catch() {
  echo "Error occured in Line $2: For more information look in errors.txt file in log directory"
}

PASSWORD=`/usr/bin/cat /home/flashzboi/autobackup/pwd.password 2>>$PATH/log/errors.txt`

#checking if password file is empty
if [ "$PASSWORD" != "" ]
then
  echo "Password detected."
else
  echo "No Password detected. Exiting..."
  exit
fi

read -s -p "Password: " MYPASSWORD
if [ "$MYPASSWORD" == "$PASSWORD"  ]
then
  logprintf "\nServer restore will begin in a few sceonds. If you want to abort this action, press STRG + C\n"
else
  logprintf "\nPassword denied.\n"
  exit
fi

#checking if directorys already exist

SERVERDIR="/home/mc/"

clean() {
>/dev/null
}
#creating the main home directory
SERVERDIRTEST=`/usr/bin/ls $SERVERDIR 2>>/dev/null`

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
