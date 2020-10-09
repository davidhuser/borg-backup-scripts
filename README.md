# Install

```

# install borg
# ...


# install borgmatic
sudo -i
pip3 install borgmatic
cp config.yaml /etc/borgmatic/config.yaml
chmod 0600 /etc/borgmatic/config.yaml
<change passphrase in config.yaml>


reboot
cp borgmatic.timer borgmatic.service /etc/systemd/system
systemctl enable borgmatic.timer
systemctl start borgmatic.timer

# disk setup
ls -l /dev/disk/by-uuid
# in /etc/fstab file:
UUID=8bbddade-b35e-2d33-8b77-697d8b2533dd /media/david/backup auto nosuid,nodev,nofail,x-gvfs-show 0 0

```
