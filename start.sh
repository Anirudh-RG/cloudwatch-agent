#!/bin/sh
# start.sh - Script to start the metrics collector and API server

# Run the metrics script once at startup
./metrics.sh

# Ensure cronie is installed and running
sudo yum install cronie -y
sudo systemctl enable crond
sudo systemctl start crond

# Add cron job only if it doesn't already exist
crontab -l 2>/dev/null | grep -q "/app/metrics.sh" || (crontab -l 2>/dev/null; echo "* * * * * /home/ec2-user/metrics.sh") | crontab -

# Start cron daemon as a service (no need for manual execution)
sudo systemctl restart crond

# Start the Node.js server (if applicable)
node /app/server.js

echo "reached end of script"
