# focal > glusterfs-server

cd /tmp/deb-pkgs/gluster

systemctl stop glusterd
dpkg -l | grep gluster


dpkg -i libgfchangelog0_10.1-1ubuntu0.2_amd64.deb
dpkg -i libglusterd0_10.1-1ubuntu0.2_amd64.deb
dpkg -i glusterfs-common_10.1-1ubuntu0.2_amd64.deb
dpkg -i glusterfs-client_10.1-1ubuntu0.2_amd64.deb
dpkg -i glusterfs-server_10.1-1ubuntu0.2_amd64.deb
dpkg -i glusterfs-cli_10.1-1ubuntu0.2_amd64.deb


dpkg -l | grep gluster

systemctl enable --now glusterd
systemctl start glusterd
systemctl status glusterd

gluster volume info
gluster volume status
