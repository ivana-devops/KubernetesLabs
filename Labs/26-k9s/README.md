
# K8S Hands-on



---

## k9s Basics

### Prerequisites
- A running Kubernetes cluster.

---

## Introduction to k9s
k9s is a terminal-based UI to interact with your Kubernetes clusters. The goal of k9s is to make it easier to navigate, observe, and manage your applications in the wild. It continually watches Kubernetes for changes and offers subsequent commands to interact with your observed resources.

### Step 01 - Installation
- **macOS/Linux (Homebrew)**: `brew install derailed/k9s/k9s`
- **Linux (Binary)**: 
    ```bash
    curl -sS https://webinstall.dev/k9s | bash
    ```
- **Linux (Snap)**: `sudo snap install k9s`

### Step 02 - Launching k9s
Simply type `k9s` in your terminal. It will use your current kubeconfig context.

### Step 03 - Common Usage & Commands
k9s relies on powerful keyboard shortcuts. Once it's running, try these common commands:

#### Navigation
- `:pods` - List all Pods (Default view).
- `:svc` - List all Services.
- `:deploy` - List all Deployments.
- `:ns` - List all Namespaces.
- `:nodes` - List all cluster Nodes.

#### Core Shortcuts
- `j` / `k` or **Arrows** - Move up and down in lists.
- `/` - **Search**: Type to filter resources in the current view.
- `0` - **All Namespaces**: View resources across all namespaces.
- `1-9` - **Namespace Filter**: Quick-jump to specific namespaces.
- `h` or `?` - **Help**: Open the built-in k9s cheat sheet.

#### Resource Operations
- `d` - **Describe**: View the detailed descriptions of the selected resource.
- `e` - **Edit**: Open the resource manifest in your editor.
- `l` - **Logs**: View logs for the selected pod (use `f` to follow, `0` to tail).
- `s` - **Shell**: Drop into a shell within the selected container.
- `y` - **YAML**: View the resource's raw YAML manifest.
- `r` - **Restart**: Trigger a rollout restart of the selected deployment.
- `ctrl-d` - **Delete**: Safely delete the selected resource (requires confirmation).
- `ctrl-s` - **Save**: Save the current view or logs to a local file.

#### View Options
- `f` - **Full Screen**: Toggle full-screen mode for the current view.
- `ctrl-w` - **Wide Columns**: Toggle wide/extended columns for more detail.

#### Management
- `p` - **Port Forward Mapping**: Add a port forward for the selected pod or service.
- `shift-f` - **Port Forward View**: Manage and view active port forwards (use `:pf` as an alias).

---
*Next: Learn advanced k9s features and power-user customizations in [Lab 30](../30-k9s/README.md).*
