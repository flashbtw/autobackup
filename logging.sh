#!/bin/bash

#This file is still in testing format! Some commands might seem to be unnecessary.
DATE=`printf '%(%Y-%m-%d)T\n' -1`
#change this to auto detected file location
DIR="/home/flashzboi/autobackup/logtest"
PATHLOGNUMBER="$DIR/next.number"
PATHLOGNUMBERIND="$DIR/number.indicator"
PATHDATE="$DIR/date.date"
PATHDATEIND="$DIR/date.indicator"
/usr/bin/echo $DIR
/usr/bin/echo $PATHLOGNUMBER
/usr/bin/echo $PATHLOGNUMBERIND
/usr/bin/echo $DATE

#Log Number Detection
if `/usr/bin/cp $PATHLOGNUMBER $PATHLOGNUMBERIND` ; then
  /usr/bin/echo "Command succeeded"
  /usr/bin/sleep 1
  NUMBER=`/usr/bin/cat $PATHLOGNUMBER`
  NEXTNUMBER=`/usr/bin/expr $NUMBER + 1`
  {
  /usr/bin/echo $NEXTNUMBER
  } >$PATHLOGNUMBER
  /usr/bin/rm $PATHLOGNUMBERIND
else
  echo "Command failed"
  /usr/bin/sleep 3
  /usr/bin/touch $PATHLOGNUMBER
  {
  /usr/bin/echo "1"
  } 2>$PATHLOGNUMBER
fi

if `/usr/bin/cp $PATHDATE $PATHDATEIND` ; then
  /usr/bin/echo "Date File exists"
  /usr/bin/sleep 1
  CHECK1=`/usr/bin/cat $PATHDATE`
  CHECK2="$DATE"
  if [ "$CHECK1" = "$CHECK2" ]; then
    if `/usr/bin/cp $PATHLOGNUMBER $PATHLOGNUMBERIND` ; then
      /usr/bin/echo "Lognumber File exists"
      /usr/bin/sleep 1
      NUMBER=`/usr/bin/cat $PATHLOGNUMBER`
      NEXTNUMBER=`/usr/bin/expr $NUMBER + 1`
      {
      /usr/bin/echo $NEXTNUMBER
      } >$PATHLOGNUMBER
      /usr/bin/rm $PATHLOGNUMBERIND
    /usr/bin/rm $PATHDATEIND
  else
      echo "Creating Lognumber File"
      /usr/bin/sleep 1
      /usr/bin/touch $PATHLOGNUMBER
      {
      /usr/bin/echo "1"
      } 2>$PATHLOGNUMBER
  fi
else
  {
  /usr/bin/echo "$DATE"
  } >$PATHDATE
fi

#Date Log Packaging
{
/usr/bin/tar cfvz /home/flashzboi/autobackup/logtest/logs-$DATE.tar.gz --exclude='*.tar.gz' -C /home/flashzboi/autobackup/logtest/ .
} >/dev/null

#reset next.number to 1, when tar got packed

