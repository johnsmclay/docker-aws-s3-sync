#!/bin/ash

set -e

LOG_DATE=`date +'%Y-%m-%d_%H%M%S'`
LOG_FILE_NAME="${JOB_NAME}_${LOG_DATE}_sync.log"
LOG_FULL_PATH=${LOG_DIR}/${LOG_FILE_NAME}

echo "$(date) - Start"
echo "$(date) - Start" >> ${LOG_FULL_PATH}

if [[ "${MAXBW}" != "" ]]; then
	echo "Setting max_bandwidth=${MAXBW}MB/s"
	echo "Setting max_bandwidth=${MAXBW}MB/s" >> ${LOG_FULL_PATH}
	aws configure set default.s3.max_bandwidth ${MAXBW}MB/s
fi

if [[ "${MAXCR}" != "" ]]; then
	echo "Setting max_concurrent_requests=${MAXCR}"
	echo "Setting max_concurrent_requests=${MAXCR}" >> ${LOG_FULL_PATH}
	aws configure set default.s3.max_concurrent_requests ${MAXCR}
fi

if [[ "${REVERSE}" == "true" ]]; then
	export SYNCCMD="aws s3 sync s3://${BUCKET}${BUCKET_PATH} ${LOCAL_PATH} --no-progress ${PARAMS}"
else
	export SYNCCMD="aws s3 sync ${LOCAL_PATH} s3://${BUCKET}${BUCKET_PATH} --no-progress ${PARAMS}"
fi

echo "${SYNCCMD}"
echo "${SYNCCMD}" >> ${LOG_FULL_PATH}
LOG_DATE=`date +'%Y-%m-%d_%H%M%S'`
LOG_FILE_NAME="${JOB_NAME}_${LOG_DATE}_sync.log"
${SYNCCMD} 2>&1  >> ${LOG_FULL_PATH}

echo "$(date) - End"
echo "$(date) - End"  >> ${LOG_FULL_PATH}
