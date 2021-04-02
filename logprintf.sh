#!/bin/bash
source $CONFIG

logprintf () {
  printf "$@"
  printf "$@" >>$LOG_LOCATION
}
