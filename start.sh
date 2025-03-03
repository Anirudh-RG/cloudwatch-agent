#!/bin/bash
# Run metrics script once at startup
/app/metrics.sh

# Add cron job
(crontab -l 2>/dev/null | grep -q "metrics.sh") || (crontab -l 2>/dev/null; echo "* * * * * /app/metrics.sh") | crontab -

# Start cron service
service cron start

# Verify cron jobs
echo "Cron configuration:"
crontab -l

# Start Node.js server
node /app/server.js