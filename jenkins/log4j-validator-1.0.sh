#!/bin/bash
export JAVA_HOME=/usr/java/jdk1.8.0_151
file_type="pom.xml"
HOME="/var/lib/jenkins/workspace"
STD_UPPER_VER="$1"
STD_LOWER_VER="$2"
APP_DIR=$3
VUL_COUNT=0
#M2_APACHE_REPO_LOG4J_API="/var/lib/jenkins/.m2/repository/org/apache/logging/log4j/log4j-api"
M2_APACHE_REPO_LOG4J_CORE="/var/lib/jenkins/.m2/repository/org/apache/logging/log4j/log4j-core"
#M2_APACHE_REPO_LOG4J="/var/lib/jenkins/.m2/repository/log4j/log4j"
cd $HOME/$APP_DIR
VERSION_ARRAY=( $(mvn dependency:tree -Dincludes=org.apache.logging.log4j:log4j-core -f $file_type| grep -i 'log4j-core' | grep -o -P '(?<=jar:).*(?=:compile)') )
ARRAY_LENGTH=${#VERSION_ARRAY[@]}

if [[ "$ARRAY_LENGTH" -eq "0" ]]; then
  LOG4J_FLAG="Y"
else
  for i in "${VERSION_ARRAY[@]}"
  do
      if [ "$(printf '%s\n' "$STD_UPPER_VER" "$i" | sort -V | head -n1)" = "$STD_UPPER_VER" ]; then
           UPPER_LIMIT_FLAG="Y"
      else
           UPPER_LIMIT_FLAG="N"
      fi

      if [ "$(printf '%s\n' "$STD_LOWER_VER" "$i" | sort -V | head -n1)" = "$STD_LOWER_VER" ]; then
          LOWER_LIMIT_FLAG="Y"
      else
         LOWER_LIMIT_FLAG="N"
      fi

      if [[ $UPPER_LIMIT_FLAG == "N" ]] && [[ $LOWER_LIMIT_FLAG == "Y" ]] ; then
         VUL_COUNT=$((VUL_COUNT+1))
      else
         VUL_COUNT=$VUL_COUNT
      fi
  done
      if [[ "$VUL_COUNT" -gt "0" ]]; then
         LOG4J_FLAG="N"
         rm -rf $M2_APACHE_REPO_LOG4J_CORE
      else
         LOG4J_FLAG="Y"
      fi
fi
#echo $ARRAY_LENGTH
#echo $VUL_COUNT
echo $LOG4J_FLAG
