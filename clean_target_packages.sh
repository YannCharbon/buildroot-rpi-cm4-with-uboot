echo "Cleaning the target Rootfs"
cd buildroot
rm -rf output/target
find output/ -name ".stamp_target_installed" -delete
rm -f output/build/host-gcc-final-*/.stamp_host_installed
echo "Done."
echo "Run 'make' to regenerate the target Rootfs and kernel image."
