# K8S Hands-on



### Verify pre-requirements

- **`kubectl`** - short for Kubernetes Controller - is the CLI for Kubernetes cluster and is required in order to be able to run the labs.
- In order to install `kubectl` and if required creating a local cluster, please refer to [Kubernetes - Install Tools](https://kubernetes.io/docs/tasks/tools/)

---

### 01. Installing Kind

- If you don't have an existing cluster you can use google cloud for the labs hands-on
- Click on the button below to be able to run the labs on Google Shell <br/>
  **[Use: <kbd>CTRL + click to open in new window]** 

    [![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/KubernetesLabs)

- Run the following commands based on your operating system:

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

### 02. Create Kind cluster

```sh
kind create cluster
```

- You should see an output like this:

```sh
Creating cluster "kind" ...
 ΓÇó Ensuring node image (kindest/node:v1.27.3) ≡ƒû╝
 ΓÇó Preparing nodes ≡ƒôª
 ΓÇó Writing configuration ≡ƒô£
 ΓÇó Starting control-plane ≡ƒò╣∩╕Å
 ΓÇó Installing CNI ≡ƒöî
 ΓÇó Installing StorageClass ≡ƒÆ╛
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info --context kind-kind

Thanks for using kind! ≡ƒÿè
```

### 03. Check the Kind cluster status

```sh
kubectl cluster-info
```

- You should see output similar to this one:

```sh
Kubernetes control plane is running at https://127.0.0.1:6443
CoreDNS is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

### 04. Verify that the cluster is up and running

```sh
kubectl cluster-info
```

- Verify that `kubectl` is installed and configured

```bash
kubectl config view
```
!!! success "Expected Result"
    ```yaml
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority-data: DATA+OMITTED
        server: https://127.0.0.1:6443
      name: kind-kind
    contexts:
    - context:
        cluster: kind-kind
        user: kind-kind
      name: kind-kind
    current-context: kind-kind
    kind: Config
    preferences: {}
    users:
    - name: kind-kind
      user:
        client-certificate-data: REDACTED
        client-key-data: REDACTED
    ```



### 05. Verify that you can "talk" to your cluster

**Check the nodes in the Kind cluster**
```sh
# Check the nodes in the Kind cluster
kubectl get nodes
```

- You should see output similar to this:

```sh
NAME                 STATUS   ROLES           AGE    VERSION
kind-control-plane   Ready    control-plane   2m     v1.27.3
```
