#!/bin/sh
#!/bin/bash

set -e

main () {
	local readonly TARGET="borgbackup@piero.local"

	TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

	if ssh -i ~/.ssh/borgbackup "$TARGET" true; then
		echo "$TIMESTAMP  $TARGET alive and accessible via SSH"
		/usr/bin/borgmatic -c /home/david/Github/borg-backup-scripts/config.yaml --files --stats --lock-wait 600
	else
		echo "$TIMESTAMP  $TARGET not reachable."
		exit 1
	fi
}

main