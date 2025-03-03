# docker installations
`docker pull anirudh0090/monitoring-agent:v3`

## instructions to use script in ubuntu
`sudo apt update && sudo apt upgrade -y`
`sudo apt-get remove docker docker-engine docker.io`
`sudo apt-get update`
`sudo apt install docker.io -y`

## install & run docker img for the project

`sudo su` # all following commands require elevated previlages
`systemctl status docker`
if "disabled" or "inactive"
`systemctl enable docker`
`systemctl start docker`
if running & active then "
`docker pull anirudh0090/monitoring-agent:v4`
RUN docker images & find the img u just installed
`docker run -p 80:3000 <container_id(from docker images)>` # dont include "< >" just the container id

U will find the logs at http://public-ip-instance/api/metrics

# integration with dashboard to monitor multiple instances at once
--yet to be done

# Sample user data file for ubuntu img
--yet to be done
