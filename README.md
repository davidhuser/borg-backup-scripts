# Install

```
ex. /etc/fstab file:
UUID=8bbddade-b35e-2d33-8b77-697d8b2533dd /media/david/backup auto nosuid,nodev,nofail,x-gvfs-show 0 0

sudo -i
pip3 install borgmatic
cp config.yaml /etc/borgmatic/config.yaml
chmod 0600 /etc/borgmatic/config.yaml
<change passphrase in config.yaml>
# on debian: 
apt-get install systemd-sysv

reboot
cp borgmatic.timer borgmatic.service /etc/systemd/system
systemctl enable borgmatic.timer
systemctl start borgmatic.timer
```
