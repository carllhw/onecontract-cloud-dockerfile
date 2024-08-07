#!/bin/sh
# vim:sw=4:ts=4:et

set -e

entrypoint_log() {
    if [ -z "${GOLANGBASE_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

result=$(echo "$1" | grep "/app/")
if [ -n "$result" ]; then
    if find "/docker-entrypoint.d/" -mindepth 1 -maxdepth 1 -name "*sh" -print -quit 2>/dev/null | read v; then
        entrypoint_log "$0: /docker-entrypoint.d/ is not empty, will attempt to perform configuration"

        entrypoint_log "$0: Looking for shell scripts in /docker-entrypoint.d/"
        find "/docker-entrypoint.d/" -follow -mindepth 1 -maxdepth 1 -name "*sh" -print | sort -V > /tmp/docker-entrypoint-d-sort.txt
        while read -r f; do
            case "$f" in
                *.envsh)
                    if [ -x "$f" ]; then
                        entrypoint_log "$0: Sourcing $f";
                        . "$f"
                    else
                        # warn on shell scripts without exec bit
                        entrypoint_log "$0: Ignoring $f, not executable";
                    fi
                    ;;
                *.sh)
                    if [ -x "$f" ]; then
                        entrypoint_log "$0: Launching $f";
                        "$f"
                    else
                        # warn on shell scripts without exec bit
                        entrypoint_log "$0: Ignoring $f, not executable";
                    fi
                    ;;
                *) entrypoint_log "$0: Ignoring $f";;
            esac
        done < /tmp/docker-entrypoint-d-sort.txt
        rm /tmp/docker-entrypoint-d-sort.txt

        entrypoint_log "$0: Configuration complete; ready for start up"
    else
        entrypoint_log "$0: No files found in /docker-entrypoint.d/, skipping configuration"
    fi
fi

exec "$@"
