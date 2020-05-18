#!/bin/bash

echo "Installing Nextflow (requires curl, git, and java)..."
curl -s https://get.nextflow.io | bash

echo "To add nextflow to your path:"
echo "export PATH=`pwd`:\$PATH"
