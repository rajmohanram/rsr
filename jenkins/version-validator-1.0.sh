#!/bin/bash
MODE=$1
VALIDATION_VERSION=$2
PROD_MNDC_NAMESPACE=$3
PROD_MNDC_DEPLOYMENT=$4
PROD_HBDC_NAMESPACE=$5
PROD_HBDC_DEPLOYMENT=$6
PROD_MNDC_HOST="10.66.48.249"
PROD_MNDC_HOST_USER="devops"
PROD_MNDC_HOST_PASSWORD="devops@123"
PROD_HBDC_HOST="10.5.48.248"
PROD_HBDC_HOST_USER="devops"
PROD_HBDC_HOST_PASSWORD="devops@123"

PROD_MNDC_IMAGE_TAG=$(sshpass -p $PROD_MNDC_HOST_PASSWORD ssh $PROD_MNDC_HOST_USER@$PROD_MNDC_HOST kubectl -n $PROD_MNDC_NAMESPACE get deployment $PROD_MNDC_DEPLOYMENT -o jsonpath="{..image}" 2>/dev/null)
PROD_HBDC_IMAGE_TAG=$(sshpass -p $PROD_HBDC_HOST_PASSWORD ssh $PROD_HBDC_HOST_USER@$PROD_HBDC_HOST kubectl -n $PROD_HBDC_NAMESPACE get deployment $PROD_HBDC_DEPLOYMENT -o jsonpath="{..image}" 2>/dev/null)

if [ $MODE == "VAL" ]
then
     PROD_MNDC_VERSION=$(echo $PROD_MNDC_IMAGE_TAG | cut -f2 -d":" )
     PROD_HBDC_VERSION=$(echo $PROD_HBDC_IMAGE_TAG | cut -f2 -d":" )
     if [ -z "$PROD_MNDC_VERSION" ]
     then
         PROD_MNDC_VERSION_FLAG="N"
     elif [ $VALIDATION_VERSION == $PROD_MNDC_VERSION ]
     then
         PROD_MNDC_VERSION_FLAG="Y"
     else
         PROD_MNDC_VERSION_FLAG="N"
     fi

     if [ -z "$PROD_HBDC_VERSION" ]
     then
         PROD_HBDC_VERSION_FLAG="N"
     elif [ $VALIDATION_VERSION == $PROD_HBDC_VERSION ]
     then
         PROD_HBDC_VERSION_FLAG="Y"
     else
         PROD_HBDC_VERSION_FLAG="N"
     fi

     if [[ $PROD_MNDC_VERSION_FLAG == "Y" ]] || [[ $PROD_HBDC_VERSION_FLAG == "Y" ]] ; then
         PROD_VERSION_FLAG="Y"
     else
         PROD_VERSION_FLAG="N"
     fi

    echo "$PROD_VERSION_FLAG"
    #echo "$PROD_MNDC_VERSION"
    #echo "$PROD_HBDC_VERSION"
elif  [ $MODE == "QRY" ]
then
     echo "[INFO] : Current Image which is running in production cluster is as follows"
     if [ -z "$PROD_MNDC_IMAGE_TAG" ]
     then
       echo "[INFO] : MNDC-CLUSTER : N/A, Maybe application is not deployed here."
     else
       echo "[INFO] : MNDC-CLUSTER : $PROD_MNDC_IMAGE_TAG"
     fi

     if [ -z "$PROD_HBDC_IMAGE_TAG" ]
     then
       echo "[INFO] : HBDC-CLUSTER : N/A, Maybe application is not deployed here."
     else
       echo "[INFO] : HBDC-CLUSTER : $PROD_HBDC_IMAGE_TAG"
     fi  
else
  echo " "
fi 
