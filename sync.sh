#!/bin/ash

set -e

echo "$(date) - Start"

if [[ "${MAXBW}" != "" ]]; then
	echo "Setting max_bandwidth=${MAXBW}MB/s"
    aws configure set default.s3.max_bandwidth ${MAXBW}MB/s
fi

if [[ "${MAXCR}" != "" ]]; then
	echo "Setting max_concurrent_requests=${MAXCR}"
    aws configure set default.s3.max_concurrent_requests ${MAXCR}
fi

if [[ "${REVERSE}" == "true" ]]; then
    export SYNCCMD="aws s3 sync s3://$BUCKET$BUCKET_PATH /data/ $PARAMS"
else
    export SYNCCMD="aws s3 sync /data/ s3://$BUCKET$BUCKET_PATH $PARAMS"
fi

echo "${SYNCCMD}"
LOG_DATE=`date +'%Y-%m-%d_%H%M%S'`
LOG_FILE_NAME="${JOB_NAME}_${LOG_DATE}_sync.log"                                                                                                                          
${SYNCCMD} 2>&1 > ${LOG_DIR}/${LOG_FILE_NAME}

echo "$(date) End"
