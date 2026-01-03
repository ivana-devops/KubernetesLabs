![Kubernetes Logo](./assets/images/Kubernetes-Logo.wine.png)
---

## Kubernetes Labs

This is a comprehensive collection of hands-on labs designed to help you learn and master Kubernetes concepts, from basic deployments to advanced topics like Istio, ArgoCD and custom schedulers.

---

## ≡ƒôÜ What You'll Learn

* This lab series covers a wide range of `Kubernetes` topics:

<div class="grid cards" markdown>

- #### <i class="fas fa-layer-group" style="color: #3e84e0;"></i>&emsp;Basics
  Namespaces, Deployments, Services and Rollouts

- #### <i class="fas fa-database" style="color: #3e84e0;"></i>&emsp;Storage
  DataStores, Persistent Volume Claims and StatefulSets

- #### <i class="fas fa-network-wired" style="color: #3e84e0;"></i>&emsp;Networking
  Ingress Controllers and Service Mesh (Istio)

- #### <i class="fas fa-cogs" style="color: #3e84e0;"></i>&emsp;Configuration Management
  Kustomization and Helm Charts

- #### <i class="fas fa-code-branch" style="color: #3e84e0;"></i>&emsp;GitOps
  ArgoCD for continuous deployment

- #### <i class="fas fa-eye" style="color: #3e84e0;"></i>&emsp;Observability
  Istio, Kiali, Logging, Prometheus and Grafana

- #### <i class="fas fa-rocket" style="color: #3e84e0;"></i>&emsp;Advanced Topics
  Custom Resource Definitions (CRDs), Custom Schedulers and Pod Disruption Budgets

- #### <i class="fas fa-tools" style="color: #3e84e0;"></i>&emsp;Tools
  k9s, Krew, Kubeapps, Kubeadm and Rancher

</div>

---

## ≡ƒ¢á∩╕Å Prerequisites

* Before starting these labs, you should have:

  - Basic understanding of containerization (Docker)
  - Command-line (CLI) familiarity
  - A Kubernetes cluster (Minikube, Kind, or cloud-based cluster)
  - `kubectl` installed and configured

---

* Recommended Software Installations:

  | Tool Name              | Description                      |
  |------------------------|----------------------------------|
  | **DevBox**             | Development environment manager  |
  | **Docker**             | Containerization tool            |
  | **Git**                | Version control system           |
  | **Helm**               | Kubernetes package manager       |
  | **Kubernetes**         | Container orchestration platform |
  | **Node.js**            | JavaScript runtime environment   |
  | **Visual Studio Code** | Source code editor               |
  | **k9s**                | Kubernetes CLI tool              |
  | **Kind**               | Kubernetes cluster               |
  | **kubectl**            | Kubernetes command-line tool     |


---

### DevBox Installation

=== "≡ƒìÄ macOS"

    **Install DevBox using Homebrew**
    ```bash
    brew install getdevbox/tap/devbox
    ```

    **Verify installation**
    ```bash
    devbox --version
    ```
=== "≡ƒÉº Linux (Ubuntu/Debian)"

    **Download and install DevBox**
    ```bash
    curl -fsSL https://get.devbox.sh | bash
    ```

    **Restart terminal or run:**
    ```bash
    source ~/.bashrc
    ```

    **Verify installation**
    ```bash
    devbox --version
    ``` 
=== "≡ƒÉº Linux (CentOS)"

    **Download and install DevBox**
    ```bash
    curl -fsSL https://get.devbox.sh | bash
    ```

    **Restart terminal or run:**
    ```bash
    source ~/.bashrc
    ```

    **Verify installation**
    ```bash
    devbox --version
    ```
=== "Γè₧ Windows"

    **Install DevBox using Scoop**
    ```powershell
    scoop install devbox
    ```

    **Verify installation**
    ```powershell
    devbox --version
    ```
---

### ≡ƒÉ│ Docker Installation

=== "≡ƒìÄ macOS"

    **Install orbstack**
    ```bash
    brew install --cask orbstack
    ```

    **Start orbstack**
    ```bash
    open -a orbstack
    ```

=== "≡ƒÉº Linux (Ubuntu/Debian)"

    **Update package index**
    ```bash
    sudo apt-get update
    ```

    **Install Docker**
    ```bash
    curl -fsSL https://get.docker.com | sh
    ```

    **Add user to docker group**
    ```bash
    sudo usermod -aG docker $USER
    ```

    **Restart session or run:**
    ```bash
    newgrp docker
    ```

=== "≡ƒÉº Linux (CentOS)"

    **Set up the repository**
    ```bash
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    ```

    **Install Docker**
    ```bash
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    ```

    **Start Docker**
    ```bash
    sudo systemctl start docker
    ```

    **Add user to docker group**
    ```bash
    sudo usermod -aG docker $USER
    ```

    **Restart session or run:**
    ```bash
    newgrp docker
    ```  
  
=== "Γè₧ Windows"

    **Install Docker Desktop**
    ```powershell
    winget install --id Docker.DockerDesktop -e
    ```

    **Start Docker Desktop**
    ```powershell
    Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    ```
---

### ≡ƒôÑ Git Installation

=== "≡ƒìÄ macOS"

    **Install Git using Homebrew**
    ```bash
    brew install git
    ```

    **Verify installation**
    ```bash
    git --version
    ```

=== "≡ƒÉº Linux (Ubuntu/Debian)"

    **Update package index**
    ```bash
    sudo apt update
    ```

    **Install Git**
    ```bash
    sudo apt install -y git
    ```

    **Verify installation**
    ```bash
    git --version
    ```

=== "≡ƒÉº Linux (CentOS)"

    **Install Git**
    ```bash
    sudo yum install -y git
    ```

    **Verify installation**
    ```bash
    git --version
    ```

=== "Γè₧ Windows"

    Download Git from the official website: [https://git-scm.com/download/win](https://git-scm.com/download/win)

---

### ΓÜô Helm Installation

=== "≡ƒìÄ macOS"

    **Install Helm using Homebrew**
    ```bash
    brew install helm
    ```

    **Verify installation**
    ```bash
    helm version
    ```

=== "≡ƒÉº Linux (Ubuntu/Debian)"

    **Download and install Helm**
    ```bash
    curl https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz -o helm.tar.gz
    tar -zxvf helm.tar.gz
    sudo mv linux-amd64/helm /usr/local/bin/helm
    rm -rf linux-amd64 helm.tar.gz
    ```

    **Verify installation**
    ```bash
    helm version
    ```

=== "≡ƒÉº Linux (CentOS)"

    **Download and install Helm**
    ```bash
    curl https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz -o helm.tar.gz
    tar -zxvf helm.tar.gz
    sudo mv linux-amd64/helm /usr/local/bin/helm
    rm -rf linux-amd64 helm.tar.gz
    ```

    **Verify installation**
    ```bash
    helm version
    ```

=== "Γè₧ Windows"

    Download Helm from: [https://get.helm.sh/helm-v3.12.0-windows-amd64.zip](https://get.helm.sh/helm-v3.12.0-windows-amd64.zip)

---

### Γÿ╕∩╕Å kubectl Installation

=== "≡ƒìÄ macOS"

    **Install kubectl using Homebrew**
    ```bash
    brew install kubectl
    ```

    **Verify installation**
    ```bash
    kubectl version --client
    ```

=== "≡ƒÉº Linux (Ubuntu/Debian)"

    **Download kubectl**
    ```bash
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    ```

    **Make it executable**
    ```bash
    chmod +x kubectl
    ```

    **Move to PATH**
    ```bash
    sudo mv kubectl /usr/local/bin/
    ```

    **Verify installation**
    ```bash
    kubectl version --client
    ```

=== "≡ƒÉº Linux (CentOS)"

    **Download kubectl**
    ```bash
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    ```

    **Make it executable**
    ```bash
    chmod +x kubectl
    ```

    **Move to PATH**
    ```bash
    sudo mv kubectl /usr/local/bin/
    ```

    **Verify installation**
    ```bash
    kubectl version --client
    ```

=== "Γè₧ Windows"

    Download kubectl from: [https://kubernetes.io/docs/tasks/tools/](https://kubernetes.io/docs/tasks/tools/)

---

### ≡ƒƒó Node.js Installation

=== "≡ƒìÄ macOS"

    **Install Node.js using Homebrew**
    ```bash
    brew install node
    ```

    **Verify installation**
    ```bash
    node --version
    npm --version
    ```

=== "≡ƒÉº Linux (Ubuntu/Debian)"

    **Install Node.js using NodeSource repository**
    ```bash
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
    ```

    **Verify installation**
    ```bash
    node --version
    npm --version
    ```

=== "≡ƒÉº Linux (CentOS)"

    ```bash
    dnf module reset nodejs -y
    dnf module enable nodejs:20 -y
    dnf install nodejs -y
    node -v
    npm -v
    ```

=== "Γè₧ Windows"

    Download Node.js from: [https://nodejs.org/](https://nodejs.org/)

---

### ≡ƒÆ╗ Visual Studio Code Installation

=== "≡ƒìÄ macOS"

    **Install VS Code using Homebrew**
    ```bash
    brew install --cask visual-studio-code
    ```

    **Start VS Code**
    ```bash
    code .
    ```

=== "≡ƒÉº Linux (Ubuntu/Debian)"

    **Install VS Code using snap**
    ```bash
    sudo snap install code --classic
    ```

    **Or using apt repository**
    ```bash
    # wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    # sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    # sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    # sudo apt update
    # sudo apt install code
    ```

    **Start VS Code**
    ```bash
    code .
    ```

=== "≡ƒÉº Linux (CentOS)"

    **Import Microsoft GPG key**
    ```bash
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    ```

    **Add VS Code repository**
    ```bash
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    ```

    **Install VS Code**
    ```bash
    sudo yum install -y code
    ```

    **Start VS Code**
    ```bash
    code .
    ```

=== "Γè₧ Windows"

    Download Visual Studio Code from: [https://code.visualstudio.com/download](https://code.visualstudio.com/download)

---

### ≡ƒÉ╢ k9s Installation

=== "≡ƒìÄ macOS"

    **Install k9s using Homebrew**
    ```bash
    brew install k9s
    ```

    **Verify installation**
    ```bash
    k9s version
    ```

=== "≡ƒÉº Linux (Ubuntu/Debian)"

    **Install k9s using webinstall**
    ```bash
    curl -sS https://webinstall.dev/k9s | bash
    ```

    **Or download binary**
    ```bash
    # curl -L https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz -o k9s.tar.gz
    # tar -xzf k9s.tar.gz
    # sudo mv k9s /usr/local/bin/
    ```

    **Verify installation**
    ```bash
    k9s version
    ```

=== "≡ƒÉº Linux (CentOS)"

    **Download k9s binary**
    ```bash
    curl -L https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz -o k9s.tar.gz
    tar -xzf k9s.tar.gz
    sudo mv k9s /usr/local/bin/
    rm k9s.tar.gz
    ```

    **Verify installation**
    ```bash
    k9s version
    ```

=== "Γè₧ Windows"

    Download k9s from: [https://github.com/derailed/k9s/releases](https://github.com/derailed/k9s/releases)

---

### ≡ƒÄ» Kind Installation

=== "≡ƒìÄ macOS"

    **Install Kind using Homebrew**
    ```bash
    brew install kind
    ```

    **Verify installation**
    ```bash
    kind version
    ```

=== "≡ƒÉº Linux (Ubuntu/Debian)"

    **Download Kind binary**
    ```bash
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    ```

    **Verify installation**
    ```bash
    kind version
    ```

=== "≡ƒÉº Linux (CentOS)"

    **Download Kind binary**
    ```bash
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    ```

    **Verify installation**
    ```bash
    kind version
    ```

=== "Γè₧ Windows"

    Download Kind from: [https://kind.sigs.k8s.io/dl/v0.20.0/kind-windows-amd64](https://kind.sigs.k8s.io/dl/v0.20.0/kind-windows-amd64)

---

## Getting Started




Let's dive into the world of Kubernetes together!

≡ƒæë [**Start the Labs here! (Lab 00 - Verify Cluster)**](00-VerifyCluster/README.md)
