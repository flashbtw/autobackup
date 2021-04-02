PFAD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"
ERROR_LOG="$PFAD/../logs/errorlog/error.log"
echo $ERROR_LOG
exit
SCRIPT_NAME="$(basename $0)"
echo "$SCRIPT_NAME"

logecho()
(
  echo "$@"
  echo "$@" >>
)

WHOAMI=`whoami`
if [ "$WHOAMI" == "root" ]; then
  

MAIN_DIR="/home/mc"

if [ -d "$MAIN_DIR" ]; then
  logprintf "Main Directory already exists!\n9"
else
  logprintf "Main Directory does not exist, creating one..\n"
  if `/usr/bin/mkdir $MAIN_DIR 2>>$ERROR_LOG` ; then
    logprintf "Main Directory created successfully.\n"
  else
    logprintf "Main Directory can not be created. Check the latest error log.\n"
  fi
fi
