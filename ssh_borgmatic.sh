#!/bin/sh
#!/bin/bash

set -e

main () {
	local readonly TARGET="borgbackup@piero.local"

	if ssh -i ~/.ssh/borgbackup "$TARGET" true; then
		echo "$TARGET alive and accessible via SSH"
    	/usr/bin/borgmatic --files -c /home/david/Github/borg-backup-scripts/config.yaml
	else
	    echo "$TARGET not reachable."
	    exit 1
	fi
}

main