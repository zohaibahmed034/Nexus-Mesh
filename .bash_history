clear
ls
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
# Apne user ko docker group mein add karein taake sudo ke bagair chal sake
sudo usermod -aG docker $USER
# Kind download karein
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
# Execute permission dein
chmod +x ./kind
# Path mein move karein
sudo mv ./kind /usr/local/bin/kind
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kind create cluster --name k8s-cluster
sudo -s
clear
ls
rm -rf k8s-autoscaling/
sudo -s
