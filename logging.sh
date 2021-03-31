#!/bin/bash

#This file is still in testing format! Some commands might seem to be unnecessary.
DATE=`printf '%(%Y-%m-%d)T\n' -1`
#change this to auto detected file location
DIR="/home/flashzboi/autobackup/logtest"
DATEINFILE=`/usr/bin/cat $DIR/date.date`
PATHLOGNUMBER="$DIR/next.number"
PATHLOGNUMBERIND="$DIR/number.indicator"
PATHDATE="$DIR/date.date"
PATHDATEIND="$DIR/date.indicator"
/usr/bin/echo $DIR
/usr/bin/echo $PATHLOGNUMBER
/usr/bin/echo $PATHLOGNUMBERIND
/usr/bin/echo "Today is the $DATE"

#Log Number Detection
#if `/usr/bin/cp $PATHLOGNUMBER $PATHLOGNUMBERIND` ; then
#  /usr/bin/echo "Command succeeded"
#  /usr/bin/sleep 1
#  NUMBER=`/usr/bin/cat $PATHLOGNUMBER`
#  NEXTNUMBER=`/usr/bin/expr $NUMBER + 1`
#  {
#  /usr/bin/echo $NEXTNUMBER
#  } >$PATHLOGNUMBER
#  /usr/bin/rm $PATHLOGNUMBERIND
#else
#  /usr/bin/echo "Command failed"
#  /usr/bin/sleep 3
#  /usr/bin/touch $PATHLOGNUMBER
#  {
#  /usr/bin/echo "1"
#  } 2>$PATHLOGNUMBER
#fi

if `/usr/bin/cp $PATHDATE $PATHDATEIND` ; then
  /usr/bin/echo "Date File exists"
  /usr/bin/rm $PATHDATEIND
  if [ `/usr/bin/cat $PATHDATE` == $DATE ]; then
    if `/usr/bin/cp $PATHLOGNUMBER $PATHLOGNUMBERIND` ; then
      /usr/bin/echo "Log Number File exists"
      /usr/bin/sleep 1
      NUMBER=`/usr/bin/cat $PATHLOGNUMBER`
      NEXTNUMBER=`/usr/bin/expr $NUMBER + 1`
      {
      /usr/bin/echo $NEXTNUMBER
      } >$PATHLOGNUMBER
      /usr/bin/rm $PATHLOGNUMBERIND
    else
      echo "Creating Log Number File"
      /usr/bin/sleep 1
      /usr/bin/touch $PATHLOGNUMBER
      {
      /usr/bin/echo "1"
      } >$PATHLOGNUMBER
      LOGNUMBER=`/usr/bin/cat $PATHLOGNUMBER`
    fi
  else
    {
    /usr/bin/tar cfvz $DIR/logs-$DATEINFILE.tar.gz --exclude='*.tar.gz' --exclude='*.number' --exclude='*.date' -C /home/flashzboi/autobackup/logtest/ .
    /usr/bin/rm $DIR/*.log
    /usr/bin/rm $DIR/*.txt
    } >>/dev/null
    {
    /usr/bin/echo $DATE
    } >$PATHDATE
  fi
else
  /usr/bin/echo "Creating Date File"
  {
  /usr/bin/echo "$DATE"
  } >$PATHDATE
fi
#Date Log Packaging
#{
#/usr/bin/tar cfvz /home/flashzboi/autobackup/logtest/logs-$DATE.tar.gz --exclude='*.tar.gz' -C /home/flashzboi/autobackup/logtest/ .
#} >/dev/null

#reset next.number to 1, when tar got packed

