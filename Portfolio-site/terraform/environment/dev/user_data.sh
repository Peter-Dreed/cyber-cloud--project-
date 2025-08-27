#!/bin/bash
set -euxo pipefail

# Update package index
apt-get update -y

# Install Docker dependencies
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
systemctl start docker
systemctl enable docker

echo "Portfolio site environment setup completed" > /var/log/portfolio-setup.log