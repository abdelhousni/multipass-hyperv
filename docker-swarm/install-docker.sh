# 1. https://shape.host/resources/install-docker-swarm-on-ubuntu-22-04
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release -y

# 2. Add the Docker GPG key and repository to your systems with the following commands:
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Manage Docker as a non-root user
## Create the docker group
sudo groupadd docker

## Add your user to the docker group
sudo usermod -aG docker $USER

## Enable the docker daemon to run on system boot
sudo systemctl enable docker


sudo systemctl is-enabled docker
sudo systemctl status docker
