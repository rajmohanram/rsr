# clean up jenkins VM
- disable and delete jenkins service
- delete /opt/jenkis & /data/jenkins
- uninstall docker apt remove --purge docker.io

# Setus GlusterFS
jenkins_vol     replica 3   /data/jenkins
mkdir /jenkins_vol

/etc/fstab
localhost:/jenkins_vol /jenkins_vol glusterfs	defaults	0	0



# Setup K3s
mkdir -p /var/lib/rancher/k3s/agent/images/

cp k3s-airgap-images-arm64.tar.zst /var/lib/rancher/k3s/agent/images/

install k3s-arm64 /usr/local/bin/k3s

chmod +x install.sh

K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="server --disable=traefik --cluster-cidr='10.32.0.0/16' --service-cidr='10.96.0.0/16'" ./install.sh

kubectl label nodes jenkins-k8s svccontroller.k3s.cattle.io/enablelb=true

Change web exposed port to 8080

Apply ingressroute for Traefik Dashboard

# Join worker node
cat /var/lib/rancher/k3s/server/token

INSTALL_K3S_SKIP_DOWNLOAD=true K3S_URL=https://192.168.0.11:6443 K3S_TOKEN=K1096ea22129562880bc73916b886170c30dc940b38add7880d0057a63076fb046e::server:f005fc2e5f58794ec0b31d2ff52066af ./install.sh


# Setup NFS provisioner
k apply -f rbac.yaml -f storageclass.yaml
k apply -f deployment.yaml

# Jenkins images - push to internal harbor registry (jenkins)
docker pull jenkins/jenkins:lts
docker pull jenkins/inbound-agent:jdk17

# Setup Jenkins controller
k create ns jenkins
k apply -f pvc.yaml -f rbac.yaml -f svc.yaml
k apply -f deployment.yaml

install / cp plugins using kubectl

setup K8s cloud
