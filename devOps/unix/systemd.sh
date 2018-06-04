#To tell systemd to start services automatically at boot, you must enable them
sudo systemctl enable application

#Execute as root
chmod 664 /etc/systemd/system/name.service

systemctl status pingPaymentEvent.service
