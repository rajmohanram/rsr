##!/usr/bin/env bash
input=$1
destination="/var/lib/jenkins/workspace"
project_key=$(echo $input | cut -f2 -d"/")
project_name=$(echo $project_key | grep -oP '(?<=build-).*(?=)')
template="sonar-scanner.properties"
rm -rf $project_name
mkdir $project_name
file=$project_name/$template
cp templates/$template $file

sed -i 's/sonar.projectKey=.*/sonar.projectKey='$project_key'/' $file
sed -i 's/sonar.projectName=.*/sonar.projectName='$project_name'/' $file


rm -rf $destination/$input/$template

cp $file $destination/$input

