#!/bin/sh -l
# exit on first error and prevent filename expansion
set -euf

jq --arg cert "$1" '.verifiers.plugins as $plugins | .verifiers.plugins[$plugins | map(.name == "notaryv2") | index(true)].verificationCerts[0] |= $cert' /config.json > /.ratify/config.json
output=$(/app/ratify verify -s "$2")
echo "::set-output name=verification::$output"
success=$(cat output-false.json | jq '.isSuccess')
if [ $success = 'true']
then
    exit 0
fi

exit 1