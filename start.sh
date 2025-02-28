#!/bin/sh
# start.sh - Script to start the metrics collector and API server

# Run the metrics script once at startup
/app/metrics.sh

# Start metrics collection as a background cron job
echo "* * * * * /app/metrics.sh" > /etc/crontabs/root
crond -f &  # Run cron daemon in the background

# Start the Node.js server
node /app/server.js