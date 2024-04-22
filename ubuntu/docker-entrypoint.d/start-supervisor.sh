#!/bin/sh

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf -n 2>&1 >> /dev/null &

wait_for_it () {
    max_time_wait=30
    process_name="$1"
    waited_sec=0
    while ! pgrep "$process_name" >/dev/null && [ $waited_sec -lt $max_time_wait ]; do
        sleep 1
        waited_sec=$((waited_sec+1))
        if [ $waited_sec -ge $max_time_wait ]; then
            return 1
        fi
    done
    return 0
}

wait_for_it dockerd
if [ $? -ne 0 ]; then
    echo "Docker daemon is not running after max time"
    exit 1
else
    echo "Docker daemon is running. Proceeding with the rest of the script..."
fi