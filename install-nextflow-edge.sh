#!/bin/bash

export NXF_VER="20.11.0-edge"

echo "Installing Nextflow edge version $NXF_VER (requires curl, git, and java)..."
curl -s https://get.nextflow.io | bash

echo "To add nextflow to your path:"
echo "export PATH=`pwd`:\$PATH"
