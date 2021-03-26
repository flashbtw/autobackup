#!/bin/bash


PATH=`pwd`
#catching error messages
trap 'catch $? $LINENO' ERR

catch() {
  echo "Error occured in Line No. $2"
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
