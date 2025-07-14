#!/bin/bash
set -e

# Update and install dependencies
yum update -y
yum install -y docker git curl

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Add ec2-user to docker group
usermod -aG docker ec2-user

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Clone and set up DevLake
cd /home/ec2-user
git clone https://github.com/merico-dev/lake.git devlake-setup
cd devlake-setup

cp -arp devops/releases/lake-v0.21.0/docker-compose.yml ./
cp env.example .env
echo "ENCRYPTION_SECRET=password123" >> .env

# Start services
docker-compose up -d

# Log success
echo "User data script completed successfully" >> /var/log/user-data.log

