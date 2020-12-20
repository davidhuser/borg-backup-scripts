# Install

## Access stuff

On server:

```
sudo adduser borgbackup
mkdir -p ~/.ssh && chmod 700 ~/.ssh && touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
```

On local:

```
# create ssh keys, no passphrase, save to ~/.ssh/borgbackup
ssh-keygen -t rsa -b 4096 -C "borgbackup"
ssh-copy-id borgbackup@piero.local
```




## Server (RPi)

### Automount ext4 harddrive

```

sudo blkid

# in /etc/fstab file:
UUID=8bbddade-b35e-2d33-8b77-697d8b2533dd /mnt/backups auto nosuid,nodev,nofail,x-gvfs-show 0 0

```


### install and init borgbackup:

Save `repokey` securely.

```
# install borg, e.g. distribution package if not too old
sudo apt-cache policy borgbackup
# ...

sudo su borgbackup
borg init --encryption=repokey /mnt/backups

```




## Local (Debian-based)

```

# install borgmatic
apt install borgmatic
borgmatic --version

# install borgmatic config
cd ~/Github && git clone https://github.com/davidhuser/borg-backup-scripts && cd borg-backup-scripts

# change encryption_passphrase in config.yaml to match repokey
chmod +x ssh_borgmatic.sh

# test it
./ssh_borgmatic.sh


# add cron
0 */3 * * * /bin/bash /home/david/Github/borg-backup-scripts/ssh_borgmatic.sh

```
