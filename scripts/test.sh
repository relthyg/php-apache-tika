#!/usr/bin/env bash

ROOT=$(dirname $0)

cd "$ROOT/.."

VERSIONS=$(cat .travis.yml | grep VERSION | awk -F '=' '{print $2}')

for VERSION in $VERSIONS
do
  echo ""
  echo "Testing Apache Tika $VERSION"
  echo "----------------------------"

  java -jar "./bin/tika-server-$VERSION.jar" -enableUnsecureFeatures -enableFileUrl &> /dev/null &
  SERVER_PID=$!
  sleep 5

  APACHE_TIKA_VERSION=$VERSION phpunit --no-coverage

  kill -9 $SERVER_PID
  sleep 3
done