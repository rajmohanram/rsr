#/bin/bash
file_type="pom.xml"
home="/var/lib/jenkins/workspace"
dir=$1
cd $home/$dir
mvn -Dexec.executable='echo' -Dexec.args='${project.version}' --non-recursive exec:exec -q -f $file_type
rm -rf image_version
mvn -Dexec.executable='echo' -Dexec.args='${project.version}' --non-recursive exec:exec -q -f $file_type >> image_version
