#!/bin/bash

#This file is still in testing format! Some commands might seem to be unnecessary.
DATE=`printf '%(%Y-%m-%d)T\n' -1`
#change this to auto detected file location
PATH_LOG_DIRECTORY="/home/flashzboi/autobackup/logtest"
DATE_IN_FILE=`/usr/bin/cat $PATH_LOG_DIRECTORY/date.date`
PATH_LOGNUMBER="$PATH_LOG_DIRECTORY/next.number"
PATH_DATE="$PATH_LOG_DIRECTORY/date.date"
/usr/bin/echo $PATH_LOG_DIRECTORY
/usr/bin/echo $PATH_LOGNUMBER
/usr/bin/echo $PATH_LOGNUMBER_IND
/usr/bin/echo "Today is the $DATE"


if `/usr/bin/test -f $PATH_DATE` ; then
  /usr/bin/echo "Date File exists"
  if [ `/usr/bin/cat $PATH_DATE` == "$DATE" ]; then
    if `/usr/bin/test -f $PATH_LOGNUMBER` ; then
      /usr/bin/echo "Log Number File exists"
      /usr/bin/sleep 1
      NUMBER=`/usr/bin/cat $PATH_LOGNUMBER`
      NEXT_NUMBER=`/usr/bin/expr $NUMBER + 1`
      {
      /usr/bin/echo $NEXT_NUMBER
      } >$PATH_LOGNUMBER
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
  if `/usr/bin/test -f $PATH_LOGNUMBER` ; then
     /usr/bin/echo "Log Number File exists"
     /usr/bin/sleep 1
     NUMBER=`/usr/bin/cat $PATH_LOGNUMBER`
     NEXT_NUMBER=`/usr/bin/expr $NUMBER + 1`
     {
     /usr/bin/echo $NEXT_NUMBER
     } >$PATH_LOGNUMBER
   else
     echo "Creating Log Number File"
     /usr/bin/sleep 1
     /usr/bin/touch $PATH_LOGNUMBER
     {
     /usr/bin/echo "1"
     } >$PATH_LOGNUMBER
     LOGNUMBER=`/usr/bin/cat $PATH_LOGNUMBER`
   fi
fi
#Date Log Packaging
#{
#/usr/bin/tar cfvz /home/flashzboi/autobackup/logtest/logs-$DATE.tar.gz --exclude='*.tar.gz' -C /home/flashzboi/autobackup/logtest/ .
#} >/dev/null


