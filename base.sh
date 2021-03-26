#!/bin/bash

PASSWORD=`cat /home/flashzboi/autobackup/pwd.password`

read -s -p "Password: " MYPASSWORD
if [ "$MYPASSWORD" == "$PASSWORD"  ]
then
  printf "\nHallo :-)\n"
else
  printf "\nNö.\n"
fi

