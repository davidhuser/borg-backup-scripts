# Install

```

# make sure there is an empty HD formatted as ext4 at /media/david/backup, not mounted

# install borg, e.g. distribution package if not too old
sudo apt-cache policy borgbackup
# ...


# install borgmatic for root user
sudo -i
sudo pip3 install borgmatic --user --upgrade
echo export 'PATH="$PATH:/root/.local/bin"' >> ~/.bashrc
source ~/.bashrc
borgmatic --version

# install borgmatic config
git clone https://github.com/davidhuser/borg-backup-scripts /tmp
cd /tmp/borg-backup-scripts
cp config.yaml /etc/borgmatic/config.yaml
chmod 0600 /etc/borgmatic/config.yaml
<change passphrase in config.yaml>

borgmatic list

# disk setup +++ DANGER ZONE!
ls -l /dev/disk/by-uuid
# in /etc/fstab file:
UUID=8bbddade-b35e-2d33-8b77-697d8b2533dd /media/david/backup auto nosuid,nodev,nofail,x-gvfs-show 0 0

# systemd setup
cp borgmatic.timer borgmatic.service /etc/systemd/system
systemctl enable borgmatic.timer
systemctl start borgmatic.timer

```
