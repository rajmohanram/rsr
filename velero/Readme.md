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
    --bucket velero-mndc-qa \
    --secret-file ./credentials-velero \
    --use-volume-snapshots=false \
    --backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://10.66.100.42 \
    --dry-run -o yaml > velero-1.8.0-install.yaml

# Update install yaml with Image location

# Deploy Velero sever using Kubernetes manifest
kubectl apply -f velero-install.yaml


# Create backup - Full backup
velero backup create full-backup-0001 \
    --snapshot-volumes=false \
    --storage-location default \
    --wait

# Create backup
velero backup create cluster-backup-01 \
    --include-resources  deployments.apps,daemonsets.apps,statefulsets.apps\
    --snapshot-volumes=false \
    --storage-location default \
    --wait

velero backup describe cluster-backup-01
velero backup logs cluster-backup-01




annual-strategic-goals
appointment-portal         Active   118d
authentication             Active   93d
cert-manager               Active   193d
chetan-n                   Active   72d
common-services            Active   502d
coreapi-qa                 Active   45d
csapi                      Active   504d
default                    Active   540d
ecmp                       Active   452d
enrolment                  Active   478d
fms-ns                     Active   506d
fms-svc                    Active   519d
ingress-nginx              Active   505d
istio-system               Active   193d
knative-serving            Active   193d
kubeflow                   Active   193d
kubernetes-dashboard       Active   194d
lingala-sravani            Active   94d
local-path-storage         Active   488d
mahizh-v                   Active   94d
monitoring                 Active   417d
nehagupta-tcs              Active   94d
praveengoud-tcs            Active   94d
prometheus                 Active   179d
qc-portal                  Active   408d
resident-comm-serv         Active   443d
rohit-kar                  Active   63d
rohitadhikari-tcs          Active   94d
sambit-hota                Active   65d
shashank-tcs               Active   94d
sourav-pal                 Active   72d
sourav-pal-new             Active   84d
srivatsa-tcs               Active   94d
tabish-tcs                 Active   91d
test                       Active   23d
uidai-print-flow-service   Active   206d
unifiedapp                 Active   519d
velero                     Active   40m



velero restore create restore-1 --from-backup full-backup-0002 --include-namespaces annual-strategic-goals,appointment-portal,authentication,common-services,coreapi-qa,csapi,default,enrolment,qc-portal,resident-comm-serv,uidai-print-flow-service,unifiedapp


velero restore create restore-4 --from-backup full-backup-0002 --include-namespaces istio-system 

