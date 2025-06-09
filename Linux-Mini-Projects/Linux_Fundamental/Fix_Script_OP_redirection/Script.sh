#!/bin/bash

# ---------------------------------------------
# 🧾 Linux Redirection, Logging, and Pipes Script
# ---------------------------------------------

# Define log files
LOG_FILE="deployment.log"
ERROR_FILE="deployment_errors.log"
FULL_LOG="deployment_full.log"

# Clear old logs if they exist
> "$LOG_FILE"
> "$ERROR_FILE"
> "$FULL_LOG"

echo "--- Deployment Script Started ---" | tee -a "$FULL_LOG"

# Simulate successful command output

echo "Listing project directory..." | tee -a "$FULL_LOG"
ls -l | tee -a "$LOG_FILE" >> "$FULL_LOG"

# Simulate error (trying to list /root which needs sudo)
echo "Attempting to access restricted directory..." | tee -a "$FULL_LOG"
ls /root 2>> "$ERROR_FILE"

# Simulate input redirection (fake mail sending)
echo "Simulating mail send from file input..." | tee -a "$FULL_LOG"
echo "Deployment completed successfully." > message.txt
cat < message.txt | tee -a "$FULL_LOG"

# Pipe and filter example
echo "Filtering shell scripts in current directory..." | tee -a "$FULL_LOG"
ls -l | tee -a "$FULL_LOG" | grep ".sh" | tee -a shell_scripts.log

echo "--- Deployment Script Completed ---" | tee -a "$FULL_LOG"

# Final status
echo "Logs saved to:"
echo " - $LOG_FILE (stdout only)"
echo " - $ERROR_FILE (stderr only)"
echo " - $FULL_LOG (combined log)"
echo " - shell_scripts.log (filtered .sh files)"
