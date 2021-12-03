#!/bin/sh -l
# exit on first error and prevent filename expansion
set -euf
echo Hello $1
time=$(date)
echo "::set-output name=time::$time"

jq --arg cert "$2" '.verifiers.plugins as $plugins | .verifiers.plugins[$plugins | map(.name == "notaryv2") | index(true)].verificationCerts[0] |= $cert' config.json > /.ratify/config.json
/app/ratify verify -s "$3"