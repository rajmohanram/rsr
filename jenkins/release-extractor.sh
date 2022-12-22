#/bin/bash
FILE_TYPE="pom.xml"
HOME="/var/lib/jenkins/workspace"
mode=$1
DIR=$2
DATA=$(mvn -Dexec.executable='echo' -Dexec.args='${project.version}' --non-recursive exec:exec -q -f $HOME/$DIR/$FILE_TYPE)
  if [ "$mode" = "V" ]
  then
      echo $DATA | cut -f1 -d"-"
  elif [ "$mode" = "R" ]
  then	  
      echo $DATA | cut -f2 -d"-"
  else
      echo " "
  fi

