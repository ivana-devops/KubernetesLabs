
# K8S Hands-on



---

## Kubeapps

### Prerequisites
- A Kubernetes cluster with Helm 3 installed.

---

## Introduction to Kubeapps
Kubeapps is a web-based dashboard that allows users to deploy and manage applications on Kubernetes from a catalog of Helm charts and Operators.

### Step 01 - Installing Kubeapps
```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create namespace kubeapps
helm install kubeapps bitnami/kubeapps --namespace kubeapps
```

### Step 02 - Accessing the Dashboard
You can port-forward to access the UI:
```sh
kubectl port-forward -n kubeapps svc/kubeapps 8080:80
```

### Step 03 - Authentication
Kubeapps uses Kubernetes RBAC. You'll need to create a ServiceAccount and use its token to log in.

---
*Note: This is a placeholder for the full detailed walkthrough.*
