#!/usr/bin/env bash

set -e

if [ -n "$JAVA_OPTS" ]; then
    export JAVA_TOOL_OPTIONS="$JAVA_OPTS $JAVA_TOOL_OPTIONS"
    export JAVA_OPTS=""
fi

exec "$@"
