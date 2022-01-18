## About
An action to run [Ratify](https://github.com/deislabs/ratify) on specified images.

## Usage
``` yaml
jobs:
  ratify_job:
    runs-on: ubuntu-latest
    name: Verify subject
    steps:
      # needed if signing keys are checked into repo
      - name: checkout repo
        id: checkout
        uses: actions/checkout@v2
      # use docker/login-action@v1 if necessary
      - name: Ratify verification step
        id: ratify
        uses: nathana1/didactic-enigma@v0.2.4
        with:
          # path relative to action working directory
          signing-cert: '<my-signing-key>.crt'
          subject: '<myregistry>/<my-image>'
      - name: Get verification results
        run: echo "Verification results are ${{ steps.ratify.outputs.verification }}"
```
