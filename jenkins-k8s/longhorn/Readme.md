apt-get install open-iscsi
modprobe iscsi_tcp
cat /boot/config-`uname -r`| grep CONFIG_NFS_V4_1
cat /boot/config-`uname -r`| grep CONFIG_NFS_V4_2
apt-get install nfs-common jq

# check bash curl findmnt grep awk blkid lsblk mktemp sort printf

curl -sSfL https://raw.githubusercontent.com/longhorn/longhorn/v1.6.1/scripts/onment_check.sh | bash


systemctl status  multipathd
cat /etc/multipath.conf
ls -l /dev/

kubectl apply -f https://raw.githubusercontent.com/longhorn/longhorn/v1.6.1/deploy/longhorn.yaml


# Images
longhornio/longhorn-manager:v1.6.1
longhornio/csi-snapshotter:v6.3.2
longhornio/csi-node-driver-registrar:v2.9.2
longhornio/livenessprobe:v2.12.0
longhornio/csi-resizer:v1.9.2
longhornio/csi-attacher:v4.4.2
longhornio/csi-provisioner:v3.6.2
longhornio/longhorn-engine:v1.6.1
longhornio/longhorn-instance-manager:v1.6.1
longhornio/longhorn-share-manager:v1.6.1
