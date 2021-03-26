#!/bin/bash

PASSWORD=`cat /home/flashzboi/autobackup/pwd.pasword`
#checking if password file exists


#checking if password file is empty
if [ "$PASSWORD" != "" ]
then
  echo "Password detected."
else
  echo "No Password detected. Exiting..."
  exit
fi

if [ "$PASSWORD" != " " ]
then
  echo "Password detected."
else
  echo "No Password detected. Exiting..."
fi

read -s -p "Password: " MYPASSWORD
if [ "$MYPASSWORD" == "$PASSWORD"  ]
then
  printf "\nHallo :-)\n"
else
  printf "\nNö.\n"
fi

