#bin/bash
UPSTREAM_PROJECT=$1
DEPLOYMENT_FILE=$2
PROJECT_NAME=$3
WORKSPACE="/var/lib/jenkins/workspace"
file=$WORKSPACE/$PROJECT_NAME/$DEPLOYMENT_FILE
VERSION=$(cat $WORKSPACE/$UPSTREAM_PROJECT/image_version)
sed -i "s/{version}/$VERSION/" "$file"
#echo "Injected $VERSION version into  $DEPLOYMENT_FILE file sucessfully"
