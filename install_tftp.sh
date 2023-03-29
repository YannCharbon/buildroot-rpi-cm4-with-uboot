# From https://linuxhint.com/install_tftp_server_ubuntu/
sudo apt install tftpd-hpa
echo 'TFTP_USERNAME="tftp"' | sudo tee /etc/default/tftpd-hpa
echo 'TFTP_DIRECTORY="/srv/tftp"' | sudo tee -a /etc/default/tftpd-hpa
echo 'TFTP_ADDRESS=":69"' | sudo tee -a /etc/default/tftpd-hpa
echo 'TFTP_OPTIONS="--secure"' | sudo tee -a /etc/default/tftpd-hpa
sudo mkdir -p /srv/tftp
sudo chown tftp:tftp /srv/tftp
sudo systemctl restart tftpd-hpa
echo "Done"
