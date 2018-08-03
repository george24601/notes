#!/usr/local/bin/python3

#aws logs describe-log-streams --log-group-name

#aws logs delete-log-stream --log-group-name my-logs --log-stream-name 20150531

import boto3
import time
import datetime

client = boto3.client('logs')

LOG_GROUP_NAME = "dev_v2-cluster"
CUTOFF_SEC = time.time() - 1e5

print(f"CUTOFF second at {CUTOFF_SEC} - " +
      datetime.datetime.fromtimestamp(CUTOFF_SEC).strftime('%B %d, %Y'))


def delete_stream(stream):
    last_event_ts = stream["lastEventTimestamp"]

    should_delete = last_event_ts / 1000 < CUTOFF_SEC

    #print(f"last event at {last_event_ts}")
    if should_delete:
        stream_to_delete = stream['logStreamName']
        print("deleting " + stream_to_delete)

        delete_response = client.delete_log_stream(
            logGroupName=LOG_GROUP_NAME, logStreamName=stream_to_delete)

        print(delete_response)

    return should_delete


def singleTry(sleep_sec):
    response = client.describe_log_streams(logGroupName=LOG_GROUP_NAME)
    log_streams = response['logStreams']
    for stream in log_streams:
        if delete_stream(stream):
            time.sleep(sleep_sec)


for times in range(10):
    SLEEP_SEC = 3
    singleTry(SLEEP_SEC)
