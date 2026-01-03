# K8S Hands-on


---

## Deployment - Declarative

### Prerequisites
- K8S cluster - <a href="../00-VerifyCluster">Setting up minikube cluster instruction</a>

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ide.cloud.google.com/?cloudshell_git_repo=https://github.com/nirgeier/KubernetesLabs)  
**<kbd>CTRL</kbd> + <kbd>click</kbd> to open in new window**

---


### Step 01 - Create Namespace

- As completed in the previous lab, create the desired namespace [codewizard]:

```bash
kubectl create namespace codewizard
```
!!! success "Expected Result"
    ```text
    namespace/codewizard created
    ```

- In order to set this is as the default namespace, please refer to <a href="../01-Namespace#2-setting-the-default-namespace-for-kubectl">set default namespace</a>.

---

### Step 02 - Deploy nginx using yaml file (declarative)

- Let's create the `YAML` file for the deployment.
- If this is your first `k8s` `YAML` file, its advisable that you type it in order to get the feeling of the structure.
- Save the file with the following name: `nginx.yaml`

```yaml
apiVersion: apps/v1
kind: Deployment # We use a deployment and not pod !!!!
metadata:
  name: nginx # Deployment name
  namespace: codewizard
  labels:
    app: nginx # Deployment label
spec:
  replicas: 2
  selector:
    matchLabels: # Labels for the replica selector
      app: nginx
  template:
    metadata:
      labels:
        app: nginx # Labels for the replica selector
        version: "1.17" # Specify specific verion if required
    spec:
      containers:
        - name: nginx # The name of the pod
          image: nginx:1.17 # The image which we will deploy
          ports:
            - containerPort: 80
```

- Create the deployment using the `-f` flag & `--record=true`

  ```bash
kubectl apply -n codewizard -f nginx.yaml --record=true
```
!!! success "Expected Result"
    ```text
    deployment.apps/nginx created
    ```

---

### Step 03 - Verify that the deployment has been created

```bash
kubectl get deployments -n codewizard
```
!!! success "Expected Result"
    ```text
    NAME        DESIRED   CURRENT   UP-TO-DATE   AVAILABLE
    multitool   1         1         1            1
    nginx       1         1         1            1
    ```

---

### Step 04 - Check if the pods are running

```bash
kubectl get pods -n codewizard
```
!!! success "Expected Result"
    ```text
    NAME                         READY   STATUS    RESTARTS
    multitool-7885b5f94f-9s7xh   1/1     Running   0
    nginx-647fb5956d-v8d2w       1/1     Running   0
    ```

### Step 05 - Playing with K8S replicas

- Let's play with the replica and see K8S in action.
- Open a second terminal and execute:

```bash
kubectl get pods -n codewizard --watch
```

---

### Step 06 - Update the `nginx.yaml` file with replica's value of 5

```yaml
spec:
  replicas: 5
```

---

### Step 07 - Update the deployment using `kubectl apply`

```bash
kubectl apply -n codewizard -f nginx.yaml --record=true
```
!!! success "Expected Result"
    ```text
    deployment.apps/nginx configured
    ```
<br>

- Switch to the second terminal and you should see something like the following:

```bash
kubectl get pods --watch -n codewizard
```
!!! success "Expected Result"
    ```text
    NAME                         READY   STATUS    RESTARTS   AGE
    multitool-74477484b8-dj7th   1/1     Running   0          20m
    nginx-dc8bb9b45-hqdv9        1/1     Running   0          111s
    nginx-dc8bb9b45-vdmp5        0/1     Pending   0          0s
    nginx-dc8bb9b45-28wwq        0/1     Pending   0          0s
    nginx-dc8bb9b45-wkc68        0/1     Pending   0          0s
    ...
    ```

<br>
- Can you explain what do you see?

  `Why are there more containers than requested?`

---

### Step 08 - Scaling down with `kubectl scale`


- Scaling down using `kubectl`, and not by editing the `YAML` file:

```bash
kubectl scale -n codewizard --replicas=1 deployment/nginx
```

- Switch to the second terminal. The current output should show something like this:

```
NAME                         READY   STATUS    RESTARTS   AGE
multitool-74477484b8-dj7th   1/1     Running   0          29m
nginx-dc8bb9b45-28wwq        1/1     Running   0          4m41s
nginx-dc8bb9b45-hqdv9        1/1     Running   0          10m
nginx-dc8bb9b45-vdmp5        1/1     Running   0          4m41s
nginx-dc8bb9b45-wkc68        1/1     Running   0          4m41s
nginx-dc8bb9b45-x7j4g        1/1     Running   0          4m41s
nginx-dc8bb9b45-x7j4g        1/1     Terminating   0          6m21s
nginx-dc8bb9b45-vdmp5        1/1     Terminating   0          6m21s
nginx-dc8bb9b45-28wwq        1/1     Terminating   0          6m21s
nginx-dc8bb9b45-wkc68        1/1     Terminating   0          6m21s
nginx-dc8bb9b45-x7j4g        0/1     Terminating   0          6m22s
nginx-dc8bb9b45-vdmp5        0/1     Terminating   0          6m22s
nginx-dc8bb9b45-wkc68        0/1     Terminating   0          6m22s
nginx-dc8bb9b45-28wwq        0/1     Terminating   0          6m22s
nginx-dc8bb9b45-28wwq        0/1     Terminating   0          6m26s
nginx-dc8bb9b45-28wwq        0/1     Terminating   0          6m26s
nginx-dc8bb9b45-vdmp5        0/1     Terminating   0          6m26s
nginx-dc8bb9b45-vdmp5        0/1     Terminating   0          6m26s
nginx-dc8bb9b45-wkc68        0/1     Terminating   0          6m27s
nginx-dc8bb9b45-wkc68        0/1     Terminating   0          6m27s
nginx-dc8bb9b45-x7j4g        0/1     Terminating   0          6m27s
nginx-dc8bb9b45-x7j4g        0/1     Terminating   0          6m27s
```
