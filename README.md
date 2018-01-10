# Install

```
ex. /etc/fstab file:
UUID=8bbddade-b35e-2d33-8b77-697d8b2533dd /media/david/backup auto nosuid,nodev,nofail,x-gvfs-show 0 0
$ rm -rf /media/david/backup/lost+found
$ borg init --encryption=repokey /media/david/backup
# cp borgbackup.service /etc/systemd/system/
# systemctl enable borgbackup.service
# systemctl start borgbackup.service
# cp borgbackup.timer /etc/systemd/system
# systemctl enable borgbackup.timer
# systemctl start borgbackup.timer
# cp borg-backup.sh /home/$USER/.local/bin/borg-backup.sh
# chmod a+x /home/$USER/.local/bin/borg-backup.sh
```
