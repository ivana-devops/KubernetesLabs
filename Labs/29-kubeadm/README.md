
# K8S Hands-on



---

## Kubeadm

### Prerequisites
- Two or more Linux machines (Ubuntu 22.04 recommended).
- Full network connectivity between all machines.
- Unique hostname, MAC address, and product_uuid for every node.

---

## Introduction to Kubeadm
Kubeadm is the standard tool for bootstrapping a minimum viable Kubernetes cluster that conforms to best practices. While it focuses on the cluster lifecycle (init, join, upgrade, reset), it doesn't handle infrastructure provisioning.

### Step 01 - Installing Runtime (Docker/containerd)
Nodes must have a container runtime installed before `kubeadm` can run.

### Step 02 - Installing Kubeadm, Kubelet, and Kubectl
```sh
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl
# Add Google Cloud public signing key
# Add Kubernetes apt repository
# Install packages
```

### Step 03 - Initializing the Control Plane
```sh
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
```

### Step 04 - Joining Worker Nodes
Run the join command provided at the end of `kubeadm init` on your worker machines.

---
*Note: This is a placeholder for the full detailed walkthrough.*
