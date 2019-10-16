#!/bin/bash

if [[ "$TRAVIS_NODE_VERSION" != "10" ]]; then
  echo "Only run Lighthouse CI once per build, condititions did not match.";
  exit 0;
fi

npx http-server -p 9000 ./dist/lh-ci/ &
sleep 5

npm install -g @lhci/cli@next
lhci collect --url=http://localhost:9000/index.html
lhci assert --preset="lighthouse:recommended"
EXIT_CODE=$?

kill $!
exit $EXIT_CODE
