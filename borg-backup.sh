#!/bin/bash

main () {

	USERNAME='david'
	REPOSITORY="/media/$USERNAME/backup"
	DEVICE='/dev/sdb'

	if df | grep -qs "$REPOSITORY"; then
		echo "$REPOSITORY mounted."
	else
		/bin/su -s /bin/bash $USERNAME -c "notify-send -t 10000 $N_TITLE '$REPOSITORY not available'"
		exit 1
	fi

	/bin/su -s /bin/bash $USERNAME -c "notify-send -t 20000 '+++ Borg Backup started at $(date +%H:%M) +++'"

	# No one can answer if Borg asks these questions, it is better to just fail quickly
	# instead of hanging.
	export BORG_RELOCATED_REPO_ACCESS_IS_OK=no
	export BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK=no

	export BORG_PASSPHRASE=$(<"/home/$USERNAME/.config/BORG_PASSPHRASE")

	borg --version

	# Options for borg create
	BORG_OPTS="-v --stats --compression lz4"

	# home partition
	borg create $BORG_OPTS								\
		$REPOSITORY::'{hostname}-home-{now:%Y-%m-%d}'	\
		/home/$USERNAME									\
		--exclude "/home/$USERNAME/.cache"				\
		--exclude '*.pyc'

	# system partition
	borg create $BORG_OPTS								\
		$REPOSITORY::'{hostname}-system-{now:%Y-%m-%d}'	\
		/												\
		--exclude "/home/$USERNAME"						\
		--exclude '/var/cache'							\

	# If there is an error backing up, reset passphrase envvar and exit
	if [ ! "$?" -eq 0 ]; then
		export BORG_PASSPHRASE=""
		exit 1
	fi

	# Prune the repo of extra backups
	borg prune -v --list $REPOSITORY --prefix '{hostname}-' \
		--keep-daily=7										\
		--keep-weekly=4										\
		--keep-monthly=6									\

	# If there is an error pruning, reset passphrase envvar and exit
	if [  ! "$?" -eq 0 ]; then
		export BORG_PASSPHRASE=""
		exit 1
	fi

	# Include the remaining device capacity in the log
	df -hl | grep --color=never $DEVICE

	borg list $REPOSITORY

	# Unset the passphrase
	export BORG_PASSPHRASE=""
	
	/bin/su -s /bin/bash $USERNAME -c "notify-send -t 20000 '+++ Borg Backup finished. +++'"
	sync
	exit 0
}

main
