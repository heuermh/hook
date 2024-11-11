#!/bin/bash

echo "installing docker (requires sudo)..."
sudo dnf update
sudo dnf install docker

echo "enabling docker service..."
sudo systemctl start docker
sudo systemctl enable docker

echo "creating docker group..."
sudo usermod -aG docker $USER
newgrp docker

echo "docker service status:"
sudo systemctl status docker

echo "attempting to run docker hello-world..."
docker run hello-world
