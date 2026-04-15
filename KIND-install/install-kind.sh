#!/bin/bash

# Install KIND
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64

chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Install kubectl
VERSION="v1.31.0"
URL="https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
INSTALL_DIR="/usr/local/bin"

curl -LO "$URL"
chmod +x kubectl
sudo mv kubectl $INSTALL_DIR/

# Verify installation
kind --version
kubectl version --client

# Cleanup
rm -f kubectl
rm -f kind

echo "kind & kubectl installation complete."