
# K8S Hands-on



---

# Rancher

### Prerequisites
- A Kubernetes cluster with at least 4GB of RAM (Rancher is resource-intensive).
- Helm installed on your local machine.

---

## Introduction to Rancher
Rancher is an open-source software stack for teams adopting containers. It addresses the operational and security challenges of managing multiple Kubernetes clusters across any infrastructure, while providing DevOps teams with integrated tools for running containerized workloads.

### Step 01 - Adding the Rancher Helm Repository
```sh
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
```

### Step 02 - Creating a Namespace for Rancher
```sh
kubectl create namespace cattle-system
```

### Step 03 - Installing cert-manager
Rancher relies on cert-manager to issue certificates for its UI.
```sh
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set installCRDs=true
```

### Step 04 - Installing Rancher with Helm
```sh
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.my.org \
  --set bootstrapPassword=admin
```

---
*Note: This is a placeholder for the full detailed walkthrough.*
