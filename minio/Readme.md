# Docker images
docker pull minio/minio:latest
docker pull minio/console:latest

# Docker container - Directory
mkdir -p /opt/minio
cd /opt/minio
mkdir disk1
mkdir disk2
mkdir disk3
mkdir disk4

# Create / copy docker compose file
docker-compose up -d

# Access minio console: 8080 with admin user

# Create a user for velero and assign readwrite policy
velero
devops@123

# Create a bucket for velero backup
velero-mndc-qa

# Get minio client
curl https://dl.min.io/client/mc/release/linux-amd64/mc -o /usr/local/bin/mc
chmod +x /usr/local/bin/mc
mc --version


# set alias and check minio connectivity
mc alias set minio http://192.168.0.30:9000 admin password
mc admin info minio
mc ls -r minio/velero
