#!/bin/bash

read -s -p "Password: " MYPASSWORD
if [ "$MYPASSWORD" == "123" ]
then
  printf "\nHallo :-)\n"
else
  printf "\nNö.\n"
fi

