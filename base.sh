#!/bin/bash

WHOAMI=`whoami`

if [ "$WHOAMI" != "root" ]; then
  echo "Script must be run as root oder sudo-er"
  exit
fi

PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

#catching error messages
trap 'catch $? $LINENO' ERR

catch() {
  echo "Error occured in Line $2: For more information look in errors.txt file in log directory"
}


PASSWORD=`/usr/bin/cat /home/flashzboi/autobackup/pwd.password 2>$PATH/log/errors.txt`

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
  printf "\nHallo :-)\n"
else
  printf "\nNö.\n"
fi
{
/usr/bin/cat /gibs/nich/ 2>$PATH/log/errors.txt
} 2>>$PATH/log/errors.txt

{
/usr/bin/cat /gibt/es/nicht/
} 2>>$PATH/log/errors.txt
