#!/bin/bash

# Define the base directories
BASE_DIR="/root/code/chatgpt_telegram_bot"
SCRIPT_DIR="$BASE_DIR/bot"
LOG_DIR="$BASE_DIR/output_logs"

# Fetching the PID of the python script
pid=$(ps -ef | grep $SCRIPT_DIR/main.py | grep -v grep | awk '{print $2}')

# Set the output log filename without including the LOG_DIR path
log_filename="output_$(date +'%Y%m%d').log"

# Logging function to write a message to the log file
log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - ${1}" >> "$LOG_DIR/$log_filename"
}

# Killing the PID
if [ -n "$pid" ]; then
    echo "Killing process with PID: $pid"
    kill -9 $pid
    log_message "SYSTEM: Process stopped gracefully by $(basename $0)"
else
    echo "No process found!"
fi

