# Download these files in .27 Jenkins server
sudo mkdir -p /var/lib/rancher/k3s/agent/images/

sudo curl -L -o /var/lib/rancher/k3s/agent/images/k3s-airgap-images-amd64.tar.zst "https://github.com/k3s-io/k3s/releases/download/v1.29.3%2Bk3s1/k3s-airgap-images-arm64.tar.zst"

sudo curl -L -o /usr/local/bin/k3s "https://github.com/k3s-io/k3s/releases/download/v1.29.3%2Bk3s1/k3s-arm64"
sudo chmod +x /usr/local/bin/k3s

sudo curl -L -o install.sh "https://get.k3s.io/"
chmod +x install.sh

K3S_KUBECONFIG_MODE="644" INSTALL_K3S_SKIP_DOWNLOAD=true ./install.sh

kubectl label nodes jenkins-agent svccontroller.k3s.cattle.io/enablelb=true




# Jenkins images - push to internal harbor registry (jenkins)
docker pull jenkins/jenkins:lts
docker tag xxxxx xxxx.udai.net/jenkins/jenkins:lts
docker push xxxx.udai.net/jenkins/jenkins:lts

docker pull jenkins/inbound-agent:jdk17
docker tag xxxxx xxxx.udai.net/jenkins/inbound-agent:jdk17
docker push xxxx.udai.net/jenkins/inbound-agent:jdk17