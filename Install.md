# Install

```
# cp borgbackup.service /etc/systemd/system/
# systemctl enable borgbackup.service
# systemctl start borgbackup.service
# cp borgbackup.timer /etc/systemd/system
# systemctl enable borgbackup.timer
# systemctl start borgbackup.timer
# export BORG_PASSPHRASE='passphraseJAJFEHFI324242'
# cp borg-backup /usr/local/bin/borg-backup.sh
# chmod a+x /usr/local/bin/borg-backup.sh
```
