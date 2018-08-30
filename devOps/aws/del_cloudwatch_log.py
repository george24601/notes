#!/usr/local/bin/python3

#aws logs describe-log-streams --log-group-name

#aws logs delete-log-stream --log-group-name my-logs --log-stream-name 20150531

import datetime
import time

import boto3

CLIENT = boto3.client('logs')

LOG_GROUP_NAME = "dev-cluster"
CUTOFF_SEC = time.time() - 1e4
LAST_EVENT_TS_FIELD = "lastEventTimestamp"

print(f"CUTOFF second at {CUTOFF_SEC} - " +
      datetime.datetime.fromtimestamp(CUTOFF_SEC).strftime('%B %d, %Y'))


def delete_stream(stream):
    if LAST_EVENT_TS_FIELD in stream:
        last_event_ts = stream[LAST_EVENT_TS_FIELD]
        should_delete = last_event_ts / 1000 < CUTOFF_SEC
    else:
        should_delete = 1

    #print(f"last event at {last_event_ts}")
    if should_delete:
        stream_to_delete = stream['logStreamName']
        print("deleting " + stream_to_delete)

        delete_response = CLIENT.delete_log_stream(
            logGroupName=LOG_GROUP_NAME, logStreamName=stream_to_delete)

        print(delete_response)

    return should_delete


def single_try(sleep_sec):
    response = CLIENT.describe_log_streams(logGroupName=LOG_GROUP_NAME)
    log_streams = response['logStreams']
    for stream in log_streams:
        if delete_stream(stream):
            time.sleep(sleep_sec)


for times in range(100):
    SLEEP_SEC = 1
    single_try(SLEEP_SEC)
