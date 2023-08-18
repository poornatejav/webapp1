#!/bin/bash

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

nohup kubectl proxy --address=0.0.0.0 --port=8001 --accept-hosts='.*' &

echo "nohup kubectl proxy --address=0.0.0.0 --port=8001 --accept-hosts='.*' &" >> ~/.bashrc

