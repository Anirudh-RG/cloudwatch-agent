#!/bin/sh
# metrics.sh - Script to collect system metrics
LOG_FILE="./system_metrics.log"

# Create log file if it doesn't exist
mkdir -p $(dirname $LOG_FILE)
touch $LOG_FILE

# Collect CPU usage (100 - idle percentage)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

# Collect memory usage percentage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Collect disk usage percentage (root filesystem)
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# Current timestamp in Unix time (seconds)
TIMESTAMP=$(date +%s)

# Save the metrics in the expected format (timestamp|cpu|memory|disk)
echo "$TIMESTAMP|$CPU_USAGE|$MEM_USAGE|$DISK_USAGE" >> $LOG_FILE

# Keep the log file from growing too large (keep last 10000 lines)
if [ $(wc -l < $LOG_FILE) -gt 10000 ]; then
  tail -n 10000 $LOG_FILE > $LOG_FILE.tmp
  mv $LOG_FILE.tmp $LOG_FILE
fi