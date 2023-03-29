sudo apt install nfs-kernel-server
sudo mkdir -p /srv/nfs
sudo chown -R $USER /srv/nfs
grep -qxF '/srv/nfs 192.168.10.0/24(rw,root_squash,sync,no_subtree_check)' /etc/exports || echo '/srv/nfs 192.168.10.0/24(rw,root_squash,sync,no_subtree_check)' >> /etc/exports
sudo service nfs-kernel-server reload
showmount -e
