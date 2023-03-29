echo "Downloading Buildroot"
git clone git://git.buildroot.net/buildroot
cd buildroot/
git checkout 2023.02-rc2
echo "Applying custom RPI CM4 defconfig"
cp ../configs/buildroot-2023-rc2.config .config
make -j8
echo "Initializing git in Linux and U-Boot for convenience"
cd output/build/linux-6.1.14/
git init
git add *
git commit -m "Initial commit"
cd ../uboot-2022.04/
git init
git add *
git commit -m "Initial commit"
echo "Deploy finished"
