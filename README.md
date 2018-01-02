# Install

```
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
