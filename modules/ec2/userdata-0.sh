#!/bin/bash
exec > /tmp/userdata.log 2>&1

apt update -y
apt install -y docker.io

systemctl start docker
systemctl enable docker

sleep 15

docker run -d -p 80:80 \
  -e OPENPROJECT_SECRET_KEY_BASE=secret \
  -e OPENPROJECT_HOST__NAME=0.0.0.0:80 \
  -e OPENPROJECT_HTTPS=false \
  openproject/community:12

