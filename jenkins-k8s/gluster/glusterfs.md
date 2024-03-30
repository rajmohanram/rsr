# Disk / partition
1TB     /data/jenkins   xfs


fdisk /dev/nvme0n2
mkfs.xfs /dev/nvme0n2p1
mkdir /data
vi /etc/fstab
mount -a
df -Th

/dev/nvme0n2p1  /data xfs  defaults  0  0


# Install GlusterFS server
apt -y install glusterfs-server
systemctl enable --now glusterd
gluster --version
mkdir -p /data/jenkins 
gluster peer probe jenkins2
gluster peer probe jenkins3
gluster peer status


# Setup Gluster Volume


gluster volume create jenkins_vol replica 3 transport tcp \
jenkins1:/data/jenkins \
jenkins2:/data/jenkins \
jenkins3:/data/jenkins

gluster volume start jenkins_vol

gluster volume info jenkins_vol

gluster volume status jenkins_vol


# Setup Ganesha NFS server
gluster volume set jenkins_vol nfs.disable on

apt -y install nfs-ganesha-gluster

mv /etc/ganesha/ganesha.conf /etc/ganesha/ganesha.conf.org
touch /etc/ganesha/ganesha.conf 


NFS_CORE_PARAM {
    mount_path_pseudo = true;
    Protocols = 3,4;
}
EXPORT {
    Export_Id = 1;
    Path = "/jenkins_vol";
    FSAL {
        Name = GLUSTER;
        Hostname="192.168.0.11";
        Volume="jenkins_vol";
        Transport = tcp;
    }
    CLIENT {
        Clients = 192.168.0.11, 192.168.0.12, 192.168.0.13;
    }
    Access_type = RW;
    Squash="No_root_squash";
    Disable_ACL = FALSE;
    Pseudo = "/jenkins_vol";
    Protocols = "3","4" ;
    Transports = "UDP","TCP" ;
    SecType = "sys";
}
LOG {
    Default_Log_Level = WARN;
}


systemctl restart nfs-ganesha
systemctl enable --now nfs-ganesha
systemctl status nfs-ganesha

showmount -e 192.168.0.11
