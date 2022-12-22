#/bin/bash
BASE_DIR="/var/lib/jenkins/workspace"
JOB_NAME=$1
MODE=$2
TARGET_DIR="$BASE_DIR/$JOB_NAME"
cd $TARGET_DIR
TAG_DESCRIPTION=$(git describe --tags --match release/start/* --abbrev=1 | cut -d "/" -f4)
VERSION=$(git describe --tags --match release/start/* --abbrev=1 | cut -d "/" -f3)
RELEASE=$(echo $TAG_DESCRIPTION | cut -d "-" -f2)
FEATURE=$(echo $TAG_DESCRIPTION | cut -d "-" -f1)
case $MODE in
    V)
  echo $VERSION ;;
    R)
  echo $RELEASE ;;
    F)
  echo $FEATURE ;;
   *)
  echo " " ;;
esac 

