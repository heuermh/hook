#!/bin/bash

echo "Installing docker on AWS EC2 as a service (sudo required)..."
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user

echo "Log out and back in to pick up environment updates."
