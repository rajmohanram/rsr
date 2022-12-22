#/bin/bash
JENKINS_WORKSPACE="/var/lib/jenkins/workspace"
PROJECT=$1
FPR_FILE=$2
cd $JENKINS_WORKSPACE/$PROJECT
IDEAL_CRITICAL_VA_COUNT=0
IDEAL_HIGH_VA_COUNT=0
CRITICAL_VA_COUNT=$(FPRUtility -information -search -query "[fortify priority order]:critical" -project $FPR_FILE | grep -o -P '(?<=).*(?= issues of)')
HIGH_VA_COUNT=$(FPRUtility -information -search -query "[fortify priority order]:high" -project $FPR_FILE | grep -o -P '(?<=).*(?= issues of)')

if [ -z "$CRITICAL_VA_COUNT" ]
then
      CRITICAL_VA_COUNT=0
else
      CRITICAL_VA_COUNT=$CRITICAL_VA_COUNT
fi

if [ -z "$HIGH_VA_COUNT" ]
then
      HIGH_VA_COUNT=0
else
      HIGH_VA_COUNT=$HIGH_VA_COUNT
fi

if [[ $CRITICAL_VA_COUNT -gt $IDEAL_CRITICAL_VA_COUNT ]] || [[ $HIGH_VA_COUNT -gt $IDEAL_HIGH_VA_COUNT ]] ; then
  echo "F"
else
  echo "P"
fi

#echo $CRITICAL_VA_COUNT
#echo $HIGH_VA_COUNT
