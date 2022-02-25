# Docker images (pull & push to harbor registry)
docker pull velero/velero:v1.8.0
docker pull velero/velero-plugin-for-aws:v1.4.0

# Velero client (makes use of kubeconfig to communicate with Velero server in K8s cluster)
wget https://github.com/vmware-tanzu/velero/releases/download/v1.8.0/velero-v1.8.0-linux-amd64.tar.gz
tar -xvzf velero-v1.8.0-linux-amd64.tar.gz
cd velero-v1.8.0-linux-amd64
chmod +x velero
cp ./velero /usr/local/bin
velero version --client-only
velero version

# Create install YAML (update MINIO details: bucket name, credentials, MinIO IP)
velero install \
    --provider aws \
    --plugins velero/velero-plugin-for-aws:v1.4.0 \
    --bucket velero-backup \
    --secret-file ./credentials-velero \
    --use-volume-snapshots=false \
    --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://192.168.0.30:9000 \
    --dry-run -o yaml > velero-1.8.0-install.yaml

# Update install yaml with Image location

# Deploy Velero sever using Kubernetes manifest
kubectl apply -f velero-install.yaml


# Create backup
velero backup create cluster-backup-01 \
    --include-resources  deployments.apps,daemonsets.apps,statefulsets.apps\
    --snapshot-volumes=false \
    --storage-location default \
    --wait

velero backup describe cluster-backup-01
velero backup logs cluster-backup-01
