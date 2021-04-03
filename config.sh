PFAD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
PASSWORD=`/usr/bin/cat $PFAD/pwd.password`
CUSTOM_CMD_PATH="$PFAD/custom"

### Date ###
DATE_PATH="$PFAD/date.date"
### Log ###
LOG_NUMBER=`/usr/bin/cat $PFAD/logs/next.number`
LOG_DIRECTORY="$PFAD/logs/log/"
LOG_NAME="latest$LOG_NUMBER.log"
LOG_LOCATION="$PFAD/logs/log/$LOG_NAME"

### Error Log ###
ERROR_LOG_DIRECTORY="$PFAD/logs/errorlog"
ERROR_LOG_NAME="error$LOG_NUMBER.log"
ERROR_LOG_LOCATION="$PFAD/logs/errorlog/$ERROR_LOG_NAME"


##### FUNCTIONS #####

### Error Catch ###
function errorcatcher {
  trap 'catch $? $LINENO' ERR
  catch() {
    echo "Error occured in Line $2: For more information look in errors.txt file in log directory"
  }
}

### Logging ###
function logprintf {
logprintf()
(
    printf "$@"
    printf "$@" >>$LOG_LOCATION
)
}

function logecho {
logecho()
(
    echo "$@"
    echo "$@" >>$LOG_LOCATION
    echo "Moin"
)
}
