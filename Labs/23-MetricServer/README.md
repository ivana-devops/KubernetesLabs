
# K8S Hands-on



---

## Metric Server

### Prerequisites
- A running Kubernetes cluster.
- `kubectl` installed.

---

## Introduction to Metric Server
Metrics Server is a scalable, efficient source of container resource metrics for Kubernetes built-in autoscaling pipelines. It collects resource metrics from Kubelets and exposes them in Kubernetes apiserver through Metrics API for use by Horizontal Pod Autoscaler and Vertical Pod Autoscaler.

### Step 01 - Installing Metrics Server
You can install Metrics Server using the official high-availability manifest:
```sh
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### Step 02 - Handling Insecure Certificates (Minikube/Kind)
Usually, in local environments, you need to allow insecure certificates:
```yaml
# Add this to the metrics-server deployment args
- --kubelet-insecure-tls
```

### Step 03 - Verifying Installation
Once installed, you can use the `top` command:
```sh
kubectl top nodes
kubectl top pods
```

---
*Note: This is a placeholder for the full detailed walkthrough.*
