#!/bin/bash

TARGET=$1
PORT=${2:-80}LOG_FILE="health_check.log"

log_message() {
    local message="$1"
    echo -e "$message"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$LOG_FILE"
}

if [ -z "$TARGET" ]; then
    echo "Error: Missing server IP/hostname argument."
    echo "Usage: $0 <IP/Hostname> [Port]"
    exit 1
fi

if ping -c 1 -W 2 "$TARGET" &> /dev/null; then
    log_message "Server $TARGET is reachable."
else
    log_message "Server $TARGET unreachable."
    exit 1
fi

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "http://$TARGET:$PORT")
if [ "$HTTP_STATUS" -ge 200 ] && [ "$HTTP_STATUS" -lt 400 ]; then
    log_message "Web service on port $PORT is UP."
else
    log_message "Web service on port $PORT is DOWN."
fi

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
log_message "Disk usage on / is $DISK_USAGE."

echo "Results logged to $LOG_FILE"
