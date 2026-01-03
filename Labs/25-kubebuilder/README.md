
# K8S Hands-on



---

## Kubebuilder

### Prerequisites
- Go (Golang) installed.
- Docker installed (for building controller images).
- `kubectl` and a test cluster.

---

## Introduction to Kubebuilder
Kubebuilder is a framework for building Kubernetes APIs using custom resource definitions (CRDs). It's similar to the Ruby on Rails or Play frameworks for web development, providing a set of tools and libraries to quickly scaffold and build Kubernetes Operators.

### Step 01 - Installing Kubebuilder
```bash
curl -L -o kubebuilder https://go.kubebuilder.io/dl/latest/$(go env GOOS)/$(go env GOARCH)
chmod +x kubebuilder && mv kubebuilder /usr/local/bin/
```

### Step 02 - Initializing a Project
```bash
kubebuilder init --domain my.domain --repo github.com/user/project
```

### Step 03 - Creating an API (CRD + Controller)
```bash
kubebuilder create api --group webapp --version v1 --kind Guestbook
```

### Step 04 - Understanding the Reconciler
The core of your operator is the `Reconcile` function, which ensures the current state of the cluster matches the desired state defined in your CRD.

---
*Note: This is a placeholder for the full detailed walkthrough.*
