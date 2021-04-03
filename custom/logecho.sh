#!/bin/bash
source $CONFIG

logecho () {
  echo "$@"
  echo "$@" >>$LOG_LOCATION
}

