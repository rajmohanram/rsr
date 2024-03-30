# focal > nfs-ganesha-gluster

cd /tmp/deb-pkgs/ganesha

systemctl stop nfs-ganesha
dpkg -l | grep ganesha


dpkg -i libc-bin_2.35-0ubuntu3.6_amd64.deb
dpkg -i libc6_2.35-0ubuntu3.6_amd64.deb
dpkg -i libssl3_3.0.2-0ubuntu1.15_amd64.deb
dpkg -i libgfrpc0_10.1-1ubuntu0.2_amd64.deb
dpkg -i libgfxdr0_10.1-1ubuntu0.2_amd64.deb
dpkg -i libglusterfs0_10.1-1ubuntu0.2_amd64.deb
dpkg -i libgfapi0_10.1-1ubuntu0.2_amd64.deb
dpkg -i liburcu8_0.13.1-1_amd64.deb
dpkg -i libntirpc3.5_3.5-2_amd64.deb
dpkg -i libboost-iostreams1.74.0_1.74.0-14ubuntu3_amd64.deb
dpkg -i libboost-thread1.74.0_1.74.0-14ubuntu3_amd64.deb
dpkg -i gcc-12-base_12.3.0-1ubuntu1~22.04_amd64.deb
dpkg -i libstdc++6_12.3.0-1ubuntu1~22.04_amd64.deb
dpkg -i librados2_17.2.7-0ubuntu0.22.04.1_amd64.deb
dpkg -i libgmp10_6.2.1+dfsg-3ubuntu1_amd64.deb
dpkg -i libhogweed6_3.7.3-1build2_amd64.deb
dpkg -i libnettle8_3.7.3-1build2_amd64.deb
dpkg -i libgnutls30_3.7.3-4ubuntu1.4_amd64.deb
dpkg -i libsasl2-modules-db_2.1.27+dfsg2-3ubuntu1.2_amd64.deb
dpkg -i libsasl2-2_2.1.27+dfsg2-3ubuntu1.2_amd64.deb
dpkg -i libldap-2.5-0_2.5.17+dfsg-0ubuntu0.22.04.1_amd64.deb
dpkg --auto-deconfigure -i libnfsidmap1_1%3a2.6.1-1ubuntu1.2_amd64.deb
dpkg -i libevent-core-2.1-7_2.1.12-stable-1build3_amd64.deb
dpkg -i nfs-common_1%3a2.6.1-1ubuntu1.2_amd64.deb
dpkg -i nfs-ganesha_3.5-1ubuntu1_amd64.deb
dpkg -i nfs-ganesha-gluster_3.5-1ubuntu1_amd64.deb


dpkg -l | grep ganesha

cat /etc/ganesha/ganesha.conf

systemctl enable --now nfs-ganesha
systemctl start nfs-ganesha
systemctl status nfs-ganesha