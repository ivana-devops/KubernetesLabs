
# K8S Hands-on



---

# Krew

### Prerequisites
- `git` version 2.19.0 or later.
- `kubectl` installed.

---

## Introduction to Krew
Krew is the plugin manager for `kubectl` command-line tool. It helps you discover, install, and manage plugins that extend the functionality of `kubectl`.

### Step 01 - Installation
Follow the instructions at [krew.sigs.k8s.io](https://krew.sigs.k8s.io/docs/user-guide/setup/install/) for your specific OS.

### Step 02 - Updating the Plugin List
```sh
kubectl krew update
```

### Step 03 - Searching for Plugins
```sh
kubectl krew search
```

### Step 04 - Installing a Plugin
For example, to install the `who-can` plugin:
```sh
kubectl krew install who-can
```

---
*Note: This is a placeholder for the full detailed walkthrough.*
