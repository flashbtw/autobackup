#!/bin/bash

WHOAMI=`whoami`
PATH1="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)""/zahlen"
ZAHLEN=$(ls $PATH1)
#verifying User

if [ "$WHOAMI" != "root" ]; then
  echo "script must be run as root user or sudoer"
  exit
fi

cd $PATH1

for file in $ZAHLEN;
do
  bash "$PATH1/$file"
done

exit
