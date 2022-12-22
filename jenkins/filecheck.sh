#/bin/bash
BASE_DIR="/var/lib/jenkins/workspace"
WORK=$1
FILE=$BASE_DIR/$WORK
if test -f "$FILE"; then
   echo "Y"
else 
   echo "N"
fi      
