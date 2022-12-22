#!/bin/bash
export JAVA_HOME=/usr/java/jdk1.8.0_151
file_type="pom.xml"
home="/var/lib/jenkins/workspace"
STD_UPPER_VER="$1"
STD_LOWER_VER="$2"
dir=$3
cd $home/$dir
APP_VER=$(mvn dependency:tree -Dincludes=log4j:log4j -f $file_type | grep -o -P '(?<=log4j:jar:).*(?=:compile)')

if [ "$(printf '%s\n' "$STD_UPPER_VER" "$APP_VER" | sort -V | head -n1)" = "$STD_UPPER_VER" ]; then
    UPPER_LIMIT_FLAG="Y"
else
    UPPER_LIMIT_FLAG="N" 
fi

if [ "$(printf '%s\n' "$STD_LOWER_VER" "$APP_VER" | sort -V | head -n1)" = "$STD_LOWER_VER" ]; then
    LOWER_LIMIT_FLAG="Y"
else
    LOWER_LIMIT_FLAG="N" 
fi

	
if [ -z "$APP_VER" ]; then
   echo "Y"
 elif [[ $UPPER_LIMIT_FLAG == "N" ]] && [[ $LOWER_LIMIT_FLAG == "Y" ]] ; then
        echo "N"
 else
        echo "Y"
 fi
