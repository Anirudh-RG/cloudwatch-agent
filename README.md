# docker installations
`docker pull anirudh0090/monitoring-agent:v3`

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
--yet to be done
