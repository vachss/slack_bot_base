#!/usr/bin/env python3

import os
import datetime
import json
import requests
import time
import schedule

INTERVAL  = int(os.environ['INTERVAL'])
SLACK_WEBHOOK = os.environ['SLACK_WEBHOOK']


def _generate_payload(content):
    """ return JSON """
    payload = {
        "username":"TestBot",
        "attachments" : [{ 
            "color":"#4169e1", 
            "text": content
        }]
    }
    return json.dumps(payload)


def send_slack(payload):
    try:
        requests.post(SLACK_WEBHOOK, payload)
    except Exception as e:
        print("sedn_slack: ERROR: ", e)


def test_job():
    content = "Test Message" 
    send_slack(_generate_payload(content))
    print(datetime.datetime.today().strftime("%Y/%m/%d %H:%M:%S"), "[TEST_JOB]: ", content)


if __name__ == "__main__":
    schedule.every(INTERVAL).minutes.do(test_job)
    while True:
        schedule.run_pending()
        time.sleep(INTERVAL * 10) # INTERVAL -> 1/6
