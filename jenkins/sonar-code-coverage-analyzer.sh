#/bin/bash
PROJECT_KEY=$1
MODE=$2
COVERAGE_THRESHOLD=$3
SONAR_UNAME="admin"
SONAR_PASSWORD="admin"
FULL_COVERAGE=$(curl -sX GET -u $SONAR_UNAME:$SONAR_PASSWORD "http://10.66.100.31:9000/api/measures/component?metricKeys=coverage&componentKey=$PROJECT_KEY" | grep -o -P '(?<="value":").*(?=","bestValue")') 
COVERAGE=$(echo $FULL_COVERAGE | cut -f1 -d"." )
 if [ "$MODE" = "C" ]
  then
    if [[ $COVERAGE -gt $COVERAGE_THRESHOLD ]] || [[ $COVERAGE -eq $COVERAGE_THRESHOLD ]] ; then
      echo "Y"
    else
      echo "N"
    fi
 elif [ "$MODE" = "Q" ]
  then
      echo $FULL_COVERAGE
 else
      echo " "
  fi
