#!/bin/bash

main () {

	REPOSITORY='/media/david/backup'
	export BORG_PASSPHRASE=$(</home/david/.config/BORG_PASSPHRASE)

	if df | grep -qs "$REPOSITORY"; then
		echo "$REPOSITORY mounted."
	else
		notify-send -t 10000 $N_TITLE "$REPOSITORY not available"
		exit
	fi

	notify-send -t 20000 "+++ Borg Backup started at $(date +%H:%M) +++"

	borg create -v --stats							\
		$REPOSITORY::'{hostname}-{now:%Y-%m-%d}'    \
		/home/david/								\
		--exclude '/home/*/.cache'					\
		--exclude '*.pyc'

	# Route the normal process logging to journalctl
	2>&1

	# Prune the repo of extra backups
	borg prune -v --list $REPOSITORY --prefix '{hostname}-' \
		--keep-daily=7										\
		--keep-weekly=4										\
		--keep-monthly=6									\


	# Include the remaining device capacity in the log
	df -hl | grep --color=never /dev/sdb

	borg list $REPOSITORY

	# Unset the passphrase
	export BORG_PASSPHRASE=""
	
	notify-send -t 20000 "+++ Borg Backup finished. +++"
	exit 0
}

main
