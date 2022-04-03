#!/bin/bash

export NXF_EDGE=1
echo "Installing latest Nextflow edge version (requires curl, git, and java)..."
curl -s https://get.nextflow.io | bash

echo "To add nextflow to your path:"
echo "export PATH=`pwd`:\$PATH"
