
# K8S Hands-on



---

# k9s

### Prerequisites
- A running Kubernetes cluster.

---

## Introduction to k9s
k9s is a terminal-based UI to interact with your Kubernetes clusters. The goal of k9s is to make it easier to navigate, observe, and manage your applications in the wild. It continually watches Kubernetes for changes and offers subsequent commands to interact with your observed resources.

### Step 01 - Installation
- **macOS/Linux**: `brew install derailed/k9s/k9s`
- **Windows**: `scoop install k9s`

### Step 02 - Launching k9s
Simply type `k9s` in your terminal. It will use your current kubeconfig context.

### Step 03 - Basic Navigation
- `:pods` - View all pods.
- `:ns` - View all namespaces.
- `d` - Describe selected resource.
- `l` - View logs of selected pod.
- `e` - Edit selected resource.

---
*Note: This is a placeholder for the full detailed walkthrough.*
