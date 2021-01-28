#!/bin/bash
INSERT_KEY=(控えておいたキー)
ACCOUNT_ID=(資料中のアカウントID)
gzip -c ../data/nrulab.json | curl --data-binary @- -X POST -H "Content-Type: application/json" \
-H "X-Insert-Key: ${INSERT_KEY}" \
-H "Content-Encoding: gzip" \
https://insights-collector.newrelic.com/v1/accounts/${ACCOUNT_ID}/events

