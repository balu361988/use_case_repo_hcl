#!/bin/bash
yum update -y
dnf install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Install Docker Compose v2
curl -L https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Write docker-compose.yml file
cat <<EOF > /home/ec2-user/docker-compose.yml
version: '3'
services:
  postgres:
    image: postgres:13
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: lake
    volumes:
      - postgres-data:/var/lib/postgresql/data
  devlake:
    image: apache/devlake:latest
    depends_on:
      - postgres
    ports:
      - "4000:4000"
    environment:
      - DB_URL=postgres://postgres:postgres@postgres:5432/lake?sslmode=disable
volumes:
  postgres-data:
EOF

# Run docker-compose
cd /home/ec2-user
docker-compose up -d

