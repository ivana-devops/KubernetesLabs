
# K8S Hands-on



---

## k9s Advanced

### Prerequisites
- `k9s` installed and basic familiarity (see Lab 26).

---

### Step 01 - Resource Utilization (`top`)
K9s integrates real-time metrics to help you identify resource-heavy pods or nodes.
- `:top pod` - View pods sorted by CPU/Memory utilization.
- `:top node` - View cluster nodes and their resource pressure.

### Step 02 - XRay & Pulses (Cluster Health)
Visualize your cluster from a high-level "cockpit" view.
- `:pulses` - A high-level dashboard showing deployment health, pod status, and resource usage in real-time.
- `:xray pods` - Visualizes the hierarchy of your pods, showing their associated Services, ConfigMaps, and Secrets.
- `:xray svc` - Visualizes services and their corresponding endpoints.

### Step 03 - RBAC Inspection (`can-i`)
Check permissions without leave the UI.
- `:can-i` - Enter the RBAC view to see exactly what you can (and cannot) do across the cluster.
- Reverse lookup: Find which Roles or ClusterRoles grant a specific permission.

### Step 04 - Multi-Cluster Context Management
Switch between clusters seamlessly.
- `:ctx` - List all contexts in your `kubeconfig`.
- Select and hit `enter` to switch to a different cluster instantly without restarting k9s.

### Step 05 - Configuration & Plugins (Power User)
K9s behavior and appearance are defined in YAML files located in `~/.config/k9s/` (on Linux) or `%LOCALAPPDATA%\k9s\` (on Windows).

#### 🎨 `config.yaml` (The UI Skin)
Use this to customize the look and feel. You can point to custom skins here.
```yaml
k9s:
  ui:
    skin: catppuccin-mocha # Reference a skin file in the /skins folder
    noIcons: false         # Enable/Disable FontAwesome icons
  refreshRate: 2           # Update UI every 2 seconds
```

#### ⚡ `aliases.yaml` (Custom Commands)
Speed up your navigation by creating short aliases for common resources.
```yaml
alias:
  # Type ':p' instead of ':pods'
  p: v1/pods
  # Type ':s' instead of ':services'
  s: v1/services
  # Type ':d' instead of ':deployments'
  d: apps/v1/deployments
```

#### 🔌 `plugin.yml` (Extend Functionality)
Plugins allow you to trigger external tools directly from the k9s UI.
```yaml
plugin:
  # Press 'Shift-D' on a pod to instantly run a debug sidecar
  debug:
    shortCut: Shift-D
    confirm: false
    description: Add Debug Sidecar
    scopes:
      - pods
    command: kubectl
    background: false
    args:
      - debug
      - -it
      - $NAME
      - --image=busybox
      - --target=$NAME
      - --namespace=$NAMESPACE
```

#### ⌨️ `hotkeys.yaml` (Global Shortcuts)
Create global hotkeys to jump to specific views from anywhere.
```yaml
hotkeys:
  # Press 'Shift-0' to jump back to the 'All Namespaces Pods' view instantly
  hotKey1:
    shortCut: Shift-0
    description: View All Pods
    command: pods --all-namespaces
```

### Step 06 - Benchmarking
If you have `hey` installed, you can benchmark services directly.
- Navigate to a Service or Pod.
- Use `ctrl-b` to initiate a benchmark and view performance results inside the TUI.

### Step 07 - Real-World Reference Files
For your convenience, we have provided a full set of production-ready configuration files in the `config_examples/` directory of this lab. You can use these as a starting point for your own environment.

- [config.yaml](./config_examples/config.yaml): Standard UI and behavior settings.
- [aliases.yaml](./config_examples/aliases.yaml): Speed up navigation with short commands like `:p` and `:s`.
- [plugin.yml](./config_examples/plugin.yml): Powerful extensions like `stern` logs and `kubectl debug`.
- [hotkeys.yaml](./config_examples/hotkeys.yaml): Global shortcuts for rapid context switching.

---
*Note: This concludes the k9s series. You are now equipped with a professional, terminal-based cockpit for Kubernetes.*
