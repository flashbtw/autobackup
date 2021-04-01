#!/bin/bash

#This file is still in testing format! Some commands might seem to be unnecessary.
DATE=`printf '%(%Y-%m-%d)T\n' -1`
#change this to auto detected file location
PATH_LOG_DIRECTORY="/home/flashzboi/autobackup/logtest"
DATE_IN_FILE=`/usr/bin/cat $PATH_LOG_DIRECTORY/date.date`
PATH_LOGNUMBER="$PATH_LOG_DIRECTORY/next.number"
PATH_LOGNUMBER_IND="$PATH_LOG_DIRECTORY/number.indicator"
PATH_DATE="$PATH_LOG_DIRECTORY/date.date"
PATH_DATE_IND="$PATH_LOG_DIRECTORY/date.indicator"
/usr/bin/echo $PATH_LOG_DIRECTORY
/usr/bin/echo $PATH_LOGNUMBER
/usr/bin/echo $PATH_LOGNUMBER_IND
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

if `/usr/bin/cp $PATH_DATE $PATH_DATE_IND` ; then
  /usr/bin/echo "Date File exists"
  /usr/bin/rm $PATH_DATE_IND
  if [ `/usr/bin/cat $PATH_DATE` == $DATE ]; then
    if `/usr/bin/cp $PATH_LOGNUMBER $PATH_LOGNUMBER_IND` ; then
      /usr/bin/echo "Log Number File exists"
      /usr/bin/sleep 1
      NUMBER=`/usr/bin/cat $PATH_LOGNUMBER`
      NEXT_NUMBER=`/usr/bin/expr $NUMBER + 1`
      {
      /usr/bin/echo $NEXT_NUMBER
      } >$PATH_LOGNUMBER
      /usr/bin/rm $PATH_LOGNUMBER_IND
    else
      echo "Creating Log Number File"
      /usr/bin/sleep 1
      /usr/bin/touch $PATH_LOGNUMBER
      {
      /usr/bin/echo "1"
      } >$PATH_LOGNUMBER
      LOGNUMBER=`/usr/bin/cat $PATH_LOGNUMBER`
    fi
  else
    {
    /usr/bin/tar cfvz $PATH_LOG_DIRECTORY/logs-$DATE_IN_FILE.tar.gz --exclude='*.tar.gz' --exclude='*.number' --exclude='*.date' -C /home/flashzboi/autobackup/logtest/ .
    /usr/bin/rm $PATH_LOG_DIRECTORY/*.log
    /usr/bin/rm $PATH_LOG_DIRECTORY/*.txt
    } >>/dev/null
    {
    /usr/bin/echo $DATE
    } >$PATH_DATE
  fi
else
  /usr/bin/echo "Creating Date File"
  {
  /usr/bin/echo "$DATE"
  } >$PATH_DATE
fi
#Date Log Packaging
#{
#/usr/bin/tar cfvz /home/flashzboi/autobackup/logtest/logs-$DATE.tar.gz --exclude='*.tar.gz' -C /home/flashzboi/autobackup/logtest/ .
#} >/dev/null


