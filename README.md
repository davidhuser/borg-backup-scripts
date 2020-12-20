# Install

## Server (RPi)

- create user
- add access for borgbackup ssh of local machine (dedicated SSH keys)
- install borgbackup:

```
# install borg, e.g. distribution package if not too old
sudo apt-cache policy borgbackup
# ...

```

Set up hard drive
```

# disk setup +++ DANGER ZONE!
ls -l /dev/disk/by-uuid
# in /etc/fstab file:
UUID=8bbddade-b35e-2d33-8b77-697d8b2533dd /media/david/backup auto nosuid,nodev,nofail,x-gvfs-show 0 0
```


## Local (Debian-based)

```

# install borgmatic
apt install borgmatic
borgmatic --version

# install borgmatic config
cd ~/Github && git clone https://github.com/davidhuser/borg-backup-scripts && cd borg-backup-scripts

# change encryption_passphrase in config.yaml
chmod +x ssh_borgmatic.sh


# add cron
0 */3 * * * /bin/bash /home/david/Github/borg-backup-scripts/ssh_borgmatic.sh

```
