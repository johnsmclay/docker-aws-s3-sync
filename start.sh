#!/bin/ash

set -e

export AWS_ACCESS_KEY_ID=$KEY
export AWS_SECRET_ACCESS_KEY=$SECRET
export AWS_DEFAULT_REGION=$REGION
export PARAMS=$PARAMS
export REVERSE=$REVERSE
export MAXBW=$MAXBW
export MAXCR=$MAXCR
export JOB_NAME=$JOB_NAME
export LOG_DIR=$LOG_DIR
export LOCAL_PATH=$LOCAL_PATH

if [[ "$1" == 'now' ]]; then
    exec /sync.sh
else
	echo "$CRON_SCHEDULE /sync.sh" >> /var/spool/cron/crontabs/root
    crond -l 2 -f
fi
