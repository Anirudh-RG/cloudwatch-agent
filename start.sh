#!/bin/sh
# start.sh - Script to start the metrics collector and API server

# Run the metrics script once at startup
/app/metrics.sh

# Setup cron job
echo "* * * * * /app/metrics.sh" > /tmp/crontab
crontab /tmp/crontab
rm /tmp/crontab

# Start cron daemon (Alpine way)
crond -b -L /app/logs/cron.log

echo "Started cron service"

# Start the Node.js server in the foreground
echo "Starting Node.js server..."
node /app/server.js