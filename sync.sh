#!/bin/ash

set -e

echo "$(date) - Start"

if [[ "${REVERSE}" == "true" ]]; then
    export SYNCCMD="aws s3 sync s3://$BUCKET$BUCKET_PATH /data/ $PARAMS"
else
	  export SYNCCMD="aws s3 sync /data/ s3://$BUCKET$BUCKET_PATH $PARAMS"
fi

echo "${SYNCCMD}"                                                                                                                             
${SYNCCMD}

echo "$(date) End"
