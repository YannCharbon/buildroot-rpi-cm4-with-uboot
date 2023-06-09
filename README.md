## Usage
Run `./deploy.sh` after cloning to automatically deploy buildroot for RPI CM4 with U-Boot.

If you need to install the TFTP server, run `./install_tftp.sh`.

If you need to install the NFS server, run `./install_nfs.sh`.

## Using CM4 with NFS
The following procedure must be run from the Buildroot root directory if nothing different is specified.

The following steps are to install the NFS server on the host :
1. `sudo apt install nfs-kernel-server`
2. `sudo mkdir /srv/nfs`
3. `sudo chown -R $USER /srv/nfs/`
4. `sudo nano /etc/exports`
    1. Add `/srv/nfs 192.168.10.0/24(rw,root_squash,sync,no_subtree_check)`
5. `sudo service nfs-kernel-server reload`
6. `showmount -e`

The following steps are to install the NFS client on the target (the current Buildroot distro already contains these elements, this is only for indication purpose) :
1. `mkdir -p board/raspberrypicm4io/rootfs_overlay/media/nfs`
2. `mkdir -p board/raspberrypicm4io/rootfs_overlay/etc`
3. `touch board/raspberrypicm4io/rootfs_overlay/etc/fstab`
    1. On CM4 : `cat /etc/fstab and copy to board/raspberrypicm4io/rootfs_overlay/etc/fstab`
    2. Add `192.168.10.2:/srv/nfs /media/nfs nfs soft,timeo=5,rsize=8192,wsize=8192 0 0` to this file
4. Auto mount during start may fail because network is not ready, so create script to mount manually from user-space.
    1. `mkdir board/raspberrypicm4io/rootfs_overlay/root/`
    2. `touch board/raspberrypicm4io/rootfs_overlay/root/nfs_mount.sh`
    3. `echo -p "mount -t nfs 192.168.10.2:/srv/nfs /media/nfs/" > board/raspberrypicm4io/rootfs_overlay/root/nfs_mount.sh`
    4. `chmod +x board/raspberrypicm4io/rootfs_overlay/root/nfs_mount.sh`
5. `make linux-menuconfig` : > File systems > Network File Systems
    1. NFS client support for NFS version 4 : yes
    2. Provide swap over NFS support : yes

## Access CM4 using SSH

1. Enable dropbear : make menuconfig → Target packages → Networking applications → Dropbear
2. Add a password to root user if there is no : make menuconfig → System configuration → Enable root login with password [y] → Root password
3. It is required to login with the following option because every time the kernel is rebuilt, the SSH footrpint is changed : `ssh -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" root@192.168.10.3`
4. The default password for `root` user of the current image is `1`

## Permanently add content to rootfs using RootFS overlay

If you want to permanently add content or override files/folders within the rootfs, you can place the content to `board/raspberrypicm4io/rootfs_overlay/`.

## Remove unwanted target packages from rootfs

Unfortunately, Buildroot does not natively support to remove an installed target package from the target rootfs. When you disable a package in the menuconfig, the binaries are not removed from the final target rootfs.
To clean the target rootfs, you can run `./clean_target_packages.sh` and run `make` to regenerate the filesystem.
