#!/bin/bash

# Define the base directories
BASE_DIR="/root/code/chatgpt_telegram_bot"
SCRIPT_DIR="$BASE_DIR/bot"
LOG_DIR="$BASE_DIR/output_logs"

# Fetching the PID of the python script
pid=$(ps -ef | grep $SCRIPT_DIR/main.py | grep -v grep | awk '{print $2}')

# Killing the PID
if [ -n "$pid" ]; then
    echo "Killing process with PID: $pid"
    kill -9 $pid
else
    echo "No process found!"
fi

# Set the output log filename without including the LOG_DIR path
log_filename="output_$(date +'%Y%m%d').log"

# Check if the log file exists for today's date
if [ -f "$LOG_DIR/$log_filename" ]; then
    echo "Log file for today already exists: $log_filename"
else
    echo "Creating log file for today: $log_filename"
    touch "$LOG_DIR/$log_filename"
fi


# Restarting the script with a nohup, in the background
nohup python $SCRIPT_DIR/main.py >> "$LOG_DIR/$log_filename" 2>&1 &
new_pid=$!
echo "Process started with PID: $new_pid"
