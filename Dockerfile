FROM alpine:3.3

RUN apk --no-cache add \
      py-pip \
      python &&\
    pip install --upgrade \
      pip \
      awscli

ENV KEY=
ENV SECRET=
ENV REGION=us-east-1
ENV BUCKET=
ENV BUCKET_PATH=/
ENV CRON_SCHEDULE="0 1 * * *"
ENV PARAMS="--no-progress"
ENV REVERSE=false
ENV MAXBW=1000
ENV MAXCR=10
ENV JOB_NAME=untitled
ENV LOG_DIR=/logging

VOLUME ["/data"]

ADD start.sh /
ADD sync.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/start.sh"]
CMD [""]
