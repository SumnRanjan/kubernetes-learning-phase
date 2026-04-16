# Kubernetes with Kind Setup

## What is Kind?

Kind stands for Kubernetes IN Docker.

It is a tool that allows you to create local Kubernetes clusters using Docker containers as nodes.

---

## Step 1: Install Docker

```bash
sudo apt update
sudo apt install -y docker.io

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker $USER
newgrp docker

docker --version
```

---

## Step 2: Install kubectl

```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

kubectl version --client
```

---

## Step 3: Install Kind

```bash
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64

# For ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-arm64

chmod +x ./kind

sudo mv ./kind /usr/local/bin/kind

kind --version
```

---

## Step 4: Create a Kubernetes Cluster

```bash
kind create cluster --name mycluster
```

---

## Step 5: Check Cluster Information

```bash
kubectl cluster-info --context kind-mycluster
```

---

## Step 6: Check Nodes

```bash
kubectl get nodes
```

You will normally see one control-plane node.

---

## Step 7: Create a Multi-Node Cluster

Create a file named `kind-config.yaml`

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4

nodes:
  - role: control-plane
  - role: worker
  - role: worker
```

Then run:

```bash
kind create cluster --name mycluster --config kind-config.yaml
```

Check nodes again:

```bash
kubectl get nodes
```

You should now see:

* 1 control-plane node
* 2 worker nodes

---

## Step 8: Create a Pod

```bash
kubectl run nginx --image=nginx
```

Check the pod:

```bash
kubectl get pods
```

---

## Step 9: Expose the Pod

```bash
kubectl expose pod nginx --type=NodePort --port=80
```

Check the service:

```bash
kubectl get svc
```

---

## Step 10: See All Resources

```bash
kubectl get all
```

---

## Step 11: See Pods in All Namespaces

```bash
kubectl get pods -A
```

---

## Step 12: Delete Pod

```bash
kubectl delete pod nginx
```

---

## Step 13: Delete Cluster

```bash
kind delete cluster --name mycluster
```

---

## Docker and Kubernetes Flow

1. Write application code
2. Create Dockerfile
3. Build Docker image
4. Push image to Docker Hub
5. Kubernetes pulls image
6. Kubernetes creates Pods from image

Example:

```bash
docker build -t myapp .

docker push mydockerhub/myapp:latest

kubectl create deployment myapp --image=mydockerhub/myapp:latest
```

---

## Useful Commands

```bash
docker --version
kubectl version --client
kind --version
kubectl get nodes
kubectl get pods
kubectl get svc
kubectl get all
```
