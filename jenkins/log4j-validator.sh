#!/bin/bash
export JAVA_HOME=/usr/java/jdk1.8.0_151
file_type="pom.xml"
home="/var/lib/jenkins/workspace"
STD_VER="$1"
dir=$2
cd $home/$dir
APP_VER=$(mvn dependency:tree -Dincludes=log4j:log4j -f $file_type | grep -o -P '(?<=log4j:jar:).*(?=:compile)')
 if [ -z "$APP_VER" ]; then
   echo "Y"
 elif [ "$(printf '%s\n' "$STD_VER" "$APP_VER" | sort -V | head -n1)" = "$STD_VER" ]; then
        echo "Y"
 else
        echo "N"
 fi
