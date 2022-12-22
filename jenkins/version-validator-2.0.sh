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
KUBE_NETWORK_VALUE_DESIRED=2
OCCURANCE_DESIRED=1


if [ $MODE == "VALUE" ]
then
     PROD_MNDC_NETWORK_VALUE=$(sshpass -p $PROD_MNDC_HOST_PASSWORD ssh $PROD_MNDC_HOST_USER@$PROD_MNDC_HOST kubectl cluster-info 2>/dev/null | grep -i 'Kubernetes master\|KubeDNS' | wc -l)
     if [ $PROD_MNDC_NETWORK_VALUE -ge $KUBE_NETWORK_VALUE_DESIRED ]
     then
        PROD_MNDC_NETWORK_FLAG="Y"
        PROD_MNDC_IMAGE_TAG=$(sshpass -p $PROD_MNDC_HOST_PASSWORD ssh $PROD_MNDC_HOST_USER@$PROD_MNDC_HOST kubectl -n $PROD_MNDC_NAMESPACE get deployment $PROD_MNDC_DEPLOYMENT -o jsonpath="{..image}" 2>/dev/null)
        PROD_MNDC_VERSION=$(echo $PROD_MNDC_IMAGE_TAG | cut -f2 -d":" )

        if [ -z "$PROD_MNDC_VERSION" ]
        then
           PROD_MNDC_VERSION_FLAG="N"
        else
            if [ "$(printf '%s\n' "$PROD_MNDC_VERSION" "$VALIDATION_VERSION" | sort -V | head -n1)" = "$PROD_MNDC_VERSION" ]; then
               PROD_MNDC_VERSION_FLAG="N"
            else
               PROD_MNDC_VERSION_FLAG="Y"
            fi

            if [ $VALIDATION_VERSION == $PROD_MNDC_VERSION ]   
            then
               PROD_MNDC_VERSION_FLAG="Y"
            else
               PROD_MNDC_VERSION_FLAG=$PROD_MNDC_VERSION_FLAG
            fi
        fi  
      else
         PROD_MNDC_NETWORK_FLAG="N"
      fi  
     PROD_HBDC_NETWORK_VALUE=$(sshpass -p $PROD_HBDC_HOST_PASSWORD ssh $PROD_HBDC_HOST_USER@$PROD_HBDC_HOST kubectl cluster-info 2>/dev/null | grep -i 'Kubernetes master\|KubeDNS' | wc -l)
     if [ $PROD_HBDC_NETWORK_VALUE -ge $KUBE_NETWORK_VALUE_DESIRED ]
     then
        PROD_HBDC_NETWORK_FLAG="Y"
        PROD_HBDC_IMAGE_TAG=$(sshpass -p $PROD_HBDC_HOST_PASSWORD ssh $PROD_HBDC_HOST_USER@$PROD_HBDC_HOST kubectl -n $PROD_HBDC_NAMESPACE get deployment $PROD_HBDC_DEPLOYMENT -o jsonpath="{..image}" 2>/dev/null)
        PROD_HBDC_VERSION=$(echo $PROD_HBDC_IMAGE_TAG | cut -f2 -d":" )

        if [ -z "$PROD_HBDC_VERSION" ]
        then
           PROD_HBDC_VERSION_FLAG="N"
        else
            if [ "$(printf '%s\n' "$PROD_HBDC_VERSION" "$VALIDATION_VERSION" | sort -V | head -n1)" = "$PROD_HBDC_VERSION" ]; then
               PROD_HBDC_VERSION_FLAG="N"
            else
               PROD_HBDC_VERSION_FLAG="Y"
            fi
            
            if [ $VALIDATION_VERSION == $PROD_HBDC_VERSION ]   
            then
               PROD_HBDC_VERSION_FLAG="Y"
            else
               PROD_HBDC_VERSION_FLAG=$PROD_HBDC_VERSION_FLAG
            fi 
        fi     
      else
          PROD_HBDC_NETWORK_FLAG="N" 
      fi 
      OCCURANCE=$(tr -dc '-' <<<"$VALIDATION_VERSION" | awk '{ print length; }')
      if [ $OCCURANCE -eq $OCCURANCE_DESIRED ]
      then
           NUM_VERSION=$(echo $VALIDATION_VERSION | cut -f1 -d"-" | tr -d '.')
           TAG=$(echo $VALIDATION_VERSION | cut -f2 -d"-")
           RE='^[0-9]+$'
           if ! [[ $NUM_VERSION =~ $RE ]] 
           then
               VERSION_NUM_FLAG="Y"
           else
               VERSION_NUM_FLAG="N"
           fi
           
           if [[ $TAG == "RELEASE" ]] || [[ $TAG == "SNAPSHOT" ]] ; then
               TAG_FLAG="N"
           else   
               TAG_FLAG="Y" 
           fi

           if [[ $VERSION_NUM_FLAG == "Y" ]] || [[ $TAG_FLAG == "Y" ]] ; then  
                STD_VERSION_FLAG="Y"
           else
                STD_VERSION_FLAG="N" 
           fi 
      else
          STD_VERSION_FLAG="N"             
      fi

     if [[ $PROD_MNDC_NETWORK_FLAG == "N" ]] || [[ $PROD_HBDC_NETWORK_FLAG == "N" ]] || [[ $PROD_MNDC_VERSION == "Y" ]] || [[ $PROD_HBDC_VERSION_FLAG == "Y" ]] || [[ $STD_VERSION_FLAG == "Y" ]]; then
         PROD_VERSION_FLAG="Y"
     else
         PROD_VERSION_FLAG="N"
     fi

    echo "$PROD_VERSION_FLAG"
    
elif  [ $MODE == "DEBUG" ]
then
     PROD_MNDC_NETWORK_VALUE=$(sshpass -p $PROD_MNDC_HOST_PASSWORD ssh $PROD_MNDC_HOST_USER@$PROD_MNDC_HOST kubectl cluster-info 2>/dev/null | grep -i running | wc -l)
     if [ $PROD_MNDC_NETWORK_VALUE -ge $KUBE_NETWORK_VALUE_DESIRED ]
     then
        PROD_MNDC_NETWORK_FLAG="Y"
        PROD_MNDC_IMAGE_TAG=$(sshpass -p $PROD_MNDC_HOST_PASSWORD ssh $PROD_MNDC_HOST_USER@$PROD_MNDC_HOST kubectl -n $PROD_MNDC_NAMESPACE get deployment $PROD_MNDC_DEPLOYMENT -o jsonpath="{..image}" 2>/dev/null)
        PROD_MNDC_VERSION=$(echo $PROD_MNDC_IMAGE_TAG | cut -f2 -d":" )

        if [ -z "$PROD_MNDC_VERSION" ]
        then
           PROD_MNDC_VERSION_FLAG="N"
        else
            if [ "$(printf '%s\n' "$PROD_MNDC_VERSION" "$VALIDATION_VERSION" | sort -V | head -n1)" = "$PROD_MNDC_VERSION" ]; then
               PROD_MNDC_VERSION_FLAG="N"
            else
               PROD_MNDC_VERSION_FLAG="Y"
            fi

            if [ $VALIDATION_VERSION == $PROD_MNDC_VERSION ]   
            then
               PROD_MNDC_VERSION_FLAG="Y"
            else
               PROD_MNDC_VERSION_FLAG=$PROD_MNDC_VERSION_FLAG
            fi
        fi  
      else
         PROD_MNDC_NETWORK_FLAG="N"
      fi  
     PROD_HBDC_NETWORK_VALUE=$(sshpass -p $PROD_HBDC_HOST_PASSWORD ssh $PROD_HBDC_HOST_USER@$PROD_HBDC_HOST kubectl cluster-info 2>/dev/null | grep -i running | wc -l)
     if [ $PROD_HBDC_NETWORK_VALUE -ge $KUBE_NETWORK_VALUE_DESIRED ]
     then
        PROD_HBDC_NETWORK_FLAG="Y"
        PROD_HBDC_IMAGE_TAG=$(sshpass -p $PROD_HBDC_HOST_PASSWORD ssh $PROD_HBDC_HOST_USER@$PROD_HBDC_HOST kubectl -n $PROD_HBDC_NAMESPACE get deployment $PROD_HBDC_DEPLOYMENT -o jsonpath="{..image}" 2>/dev/null)
        PROD_HBDC_VERSION=$(echo $PROD_HBDC_IMAGE_TAG | cut -f2 -d":" )

        if [ -z "$PROD_HBDC_VERSION" ]
        then
           PROD_HBDC_VERSION_FLAG="N"
        else
            if [ "$(printf '%s\n' "$PROD_HBDC_VERSION" "$VALIDATION_VERSION" | sort -V | head -n1)" = "$PROD_HBDC_VERSION" ]; then
               PROD_HBDC_VERSION_FLAG="N"
            else
               PROD_HBDC_VERSION_FLAG="Y"
            fi
            
            if [ $VALIDATION_VERSION == $PROD_HBDC_VERSION ]   
            then
               PROD_HBDC_VERSION_FLAG="Y"
            else
               PROD_HBDC_VERSION_FLAG=$PROD_HBDC_VERSION_FLAG
            fi 
        fi     
      else
          PROD_HBDC_NETWORK_FLAG="N" 
      fi 
      OCCURANCE=$(tr -dc '-' <<<"$VALIDATION_VERSION" | awk '{ print length; }')
      if [ $OCCURANCE -eq $OCCURANCE_DESIRED ]
      then
           NUM_VERSION=$(echo $VALIDATION_VERSION | cut -f1 -d"-" | tr -d '.')
           TAG=$(echo $VALIDATION_VERSION | cut -f2 -d"-")
           RE='^[0-9]+$'
           if ! [[ $NUM_VERSION =~ $RE ]] 
           then
               VERSION_NUM_FLAG="Y"
           else
               VERSION_NUM_FLAG="N"
           fi
           
           if [[ $TAG == "RELEASE" ]] || [[ $TAG == "SNAPSHOT" ]] ; then
               TAG_FLAG="N"
           else   
               TAG_FLAG="Y" 
           fi
   
      fi
      echo " "
      echo "[INFO] : Validating the version compliance with Production MNDC and HBDC CLUSTERS"
      echo "***************************************************************************************"
      if [ "$PROD_MNDC_NETWORK_FLAG" = "Y" ]; then
            echo " "
            echo "[INFO] : PROD-MNDC CLUSTER CONNECTION STATUS = OK"
            echo " "
            echo "[INFO] : Current Image which is running in production MNDC cluster is as follows"
         if [ -z "$PROD_MNDC_IMAGE_TAG" ]
         then
            echo "[INFO] : IMAGE : N/A, Application is not deployed in MNDC cluster"
         else
            echo "[INFO] : IMAGE : $PROD_MNDC_IMAGE_TAG"
         fi

         if [ "$PROD_MNDC_VERSION_FLAG" = "Y" ]; then 
            echo "[ERROR] : Current build version ($VALIDATION_VERSION) conflicts with the Image version which is currently running in PROD-MNDC CLUSTER"
            echo "[INFO]  : Only those versions which are greater than the current running Image version in PROD-MNDC CLUSTER are allowed to build" 
         else
            echo "[INFO]  : Current build version ($VALIDATION_VERSION) is compliant with the Image version which is currently running in PROD-MNDC CLUSTER" 
            echo "[INFO]  : Only those versions which are greater than the current running Image version in PROD-MNDC CLUSTER are allowed to build" 
         fi  

      else
         echo "[ERROR] : PROD-MNDC CLUSTER CONNECTION STATUS = NOT OK"
      fi

      if [ "$PROD_HBDC_NETWORK_FLAG" = "Y" ]; then
           echo " "
           echo "[INFO] : PROD-HBDC CLUSTER CONNECTION STATUS = OK"
           echo " "
           echo "[INFO] : Current Image which is running in production HBDC cluster is as follows"

         if [ -z "$PROD_HBDC_IMAGE_TAG" ]
         then
            echo "[INFO] : IMAGE : N/A, Application is not deployed in HBDC cluster"
         else
            echo "[INFO] : IMAGE : $PROD_HBDC_IMAGE_TAG"
         fi  
           

         if [ "$PROD_HBDC_VERSION_FLAG" = "Y" ]; then 
            echo "[ERROR] : Current build version ($VALIDATION_VERSION) conflicts with the Image version which is currently running in PROD-HBDC CLUSTER"
            echo "[INFO]  : Only those versions which are greater than the current running Image version in PROD-HBDC CLUSTER are allowed to build" 
         else
            echo "[INFO]  : Current build version ($VALIDATION_VERSION) is compliant with the Image version which is currently running in PROD-MNDC CLUSTER" 
            echo "[INFO]  : Only those versions which are greater than the current running Image version in PROD-MNDC CLUSTER are allowed to build" 
         fi 

      else
         echo "[ERROR] : PROD-HBDC CLUSTER CONNECTION STATUS = NOT OK"
      fi
      echo " "
      echo "[INFO] : Validating standard naming Conventions"
      echo "************************************************ "
      echo " "
      if [[ $VERSION_NUM_FLAG == "Y" ]] || [[ $TAG_FLAG == "Y" ]]; then
          echo "[ERROR] : Current build version ($VALIDATION_VERSION) doesn't follow the standard naming Conventions"
          echo " "
          echo "[INFO] : Build version should be <Major-version>.<Minor-version>.<Sub-version>-<version-tag>"
          echo " "
          echo "[INFO] : Numerical values are only allowed for <Major-version>,<Minor-version> and <Sub-version> But <version-tag> must be either RELEASE or SNAPSHOT"
      else
          echo "[INFO] : Current build version ($VALIDATION_VERSION) follows the standard naming Conventions"
          echo " "
          echo "[INFO] : Build version should be <Major-version>.<Minor-version>.<Sub-version>-<version-tag>"
          echo " "
          echo "[INFO] : Numerical values are only allowed for <Major-version>,<Minor-version> and <Sub-version> But <version-tag> must be either RELEASE or SNAPSHOT"
      fi
else
  echo " "
fi
