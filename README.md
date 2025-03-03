# docker installations
`docker pull anirudh0090/monitoring-agent:v4`

## instructions to use script in ubuntu
1. `sudo apt update && sudo apt upgrade -y`
2. `sudo apt-get remove docker docker-engine docker.io`
3. `sudo apt-get update`
4. `sudo apt install docker.io -y`

## install & run docker img for the project

1. `sudo su` # all following commands require elevated previlages
2. `systemctl status docker`
### if "disabled" or "inactive"
3. `systemctl enable docker`
4. `systemctl start docker`
### if running & active then "
5. `docker pull anirudh0090/monitoring-agent:v4`
### RUN docker images & find the img u just installed
6. `docker run -p 80:3000 <container_id(from docker images)>` # dont include "< >" just the container id

U will find the logs at http://public-ip-instance/api/metrics

# integration with dashboard to monitor multiple instances at once
--yet to be done

# Sample user data file for ubuntu img
- paste the following content into User data
```
#!/bin/bash

set -e  # Exit on error

LOG_FILE="/var/log/userdata.log"

# Redirect all output (stdout & stderr) to the log file, except for specified commands
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Hostname: $(hostname)"
sudo apt update -y >/dev/null 2>&1 && sudo apt upgrade -y >/dev/null 2>&1
echo "Installation done (APT logs ignored)"
# sudo apt-get remove -y docker docker-engine docker.io containerd runc
# the upper line is usually needed but for some reason the script errors out if the line is not commented


sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker


sudo docker pull anirudh0090/monitoring-agent:v4
sudo docker run -d -p 80:3000 anirudh0090/monitoring-agent:v4
echo "Reached the end of user data"
```

- to check the logs in case of container not starting, u can check the logs from this script by running
`sudo cat /var/logs/userdata.log`