# K8S Hands-on


---

## Rollout (Rolling Update)

- In this step we will deploy the same application with several different versions and we will "switch" between them.
- For learning purposes we will play a little with the `CLI`.

---
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

### Step 02 - Create the desired deployment

- We will use the `save-config` flag
  > `save-config`  
  > If true, the configuration of current object will be saved in its annotation.  
  > Otherwise, the annotation will be unchanged.  
  > This flag is useful when you want to perform `kubectl apply` on this object in the future.

- Let's run the following:
```bash
kubectl create deployment -n codewizard nginx --image=nginx:1.17 --save-config
```
!!! success "Expected Result"
    ```text
    deployment.apps/nginx created
    ```
Note that in case we already have this deployed, we will get an error message.

---

### Step 03 - Expose nginx as a service

```bash
kubectl expose deployment -n codewizard nginx --port 80 --type NodePort
```
!!! success "Expected Result"
    ```text
    service/nginx exposed
    ```
Again, note that in case we already have this service we will get an error message as well.

---

### Step 04 - Verify that the pods and the service are running

```bash
kubectl get all -n codewizard
```
!!! success "Expected Result"
    ```text
    NAME                        READY      STATUS    RESTARTS   AGE
    pod/nginx-db749865c-lmgtv   1/1        Running   0          66s

    NAME                        TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
    service/nginx               NodePort   10.102.79.9   <none>        80:31204/TCP   30s

    NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
    deployment.apps/nginx   1/1     1            1           66s

    NAME                              DESIRED   CURRENT   READY   AGE
    replicaset.apps/nginx-db749865c   1         1         1       66s
    ```

---

### Step 05 - Change the number of replicas to 3

```bash
kubectl scale deployment -n codewizard nginx --replicas=3
```
!!! success "Expected Result"
    ```text
    deployment.apps/nginx scaled
    ```

---

### Step 06 - Verify that now we have 3 replicas

```bash
kubectl get pods -n codewizard
```
!!! success "Expected Result"
    ```text
    NAME                    READY   STATUS    RESTARTS   AGE
    nginx-db749865c-f5mkt   1/1     Running   0          86s
    nginx-db749865c-jgcvb   1/1     Running   0          86s
    nginx-db749865c-lmgtv   1/1     Running   0          4m44s
    ```

---

### Step 07 - Test the deployment

```bash
kubectl get services -n codewizard -o wide
```
!!! success "Expected Result"
    ```text
    NAME    TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE    SELECTOR
    nginx   NodePort   10.102.79.9   <none>        80:31204/TCP   7m7s   app=nginx
    ```

!!! tip "Test Command"
    ```bash
    # Get the cluster IP and port
    kubectl cluster-info

    # Test the nginx server (replace with your host and port)
    curl -sI <host>:<port>
    ```

!!! note "Expected Response"
    ```text
    HTTP/1.1 200 OK
    Server: nginx/1.17.10
    ...
    ```

---

### Step 08 - Deploy another version of nginx

```bash
kubectl set image deployment -n codewizard nginx nginx=nginx:1.16 --record
```
!!! success "Expected Result"
    ```text
    deployment.apps/nginx image updated
    ```

!!! tip "Test New Version"
    ```bash
    curl -sI <host>:<port>
    ```

!!! note "Expected Response"
    ```text
    HTTP/1.1 200 OK
    Server: nginx/1.16.1
    ...
    ```

---

### Step 09 - Investigate rollout history

- The rollout history command print out all the saved records:

```bash
kubectl rollout history deployment nginx -n codewizard
```
!!! success "Expected Result"
    ```text
    deployment.apps/nginx
    REVISION  CHANGE-CAUSE
    1         <none>
    2         kubectl set image deployment nginx nginx=nginx:1.16 --record=true
    3         kubectl set image deployment nginx nginx=nginx:1.15 --record=true
    ```

---

### Step 10 - Let's see what was changed during the previous updates

- Print out the rollout changes:

```bash
# Replace <X> with a revision ID (e.g., 1 or 2)
kubectl rollout history deployment nginx -n codewizard --revision=<X>
```
!!! success "Expected Result"
    ```text
    deployment.apps/nginx with revision #1
    Pod Template:
      Labels:       app=nginx
            pod-template-hash=db749865c
      Containers:
       nginx:
        Image:      nginx:1.17
        ...
    ```

---

### Step 11 - Undo the version upgrade by rolling back and restoring previous version

```bash
# Undo the last deployment
kubectl rollout undo deployment nginx
```
!!! success "Expected Result"
    ```text
    deployment.apps/nginx rolled back
    ```

!!! tip "Verify Version"
    ```bash
    curl -sI <host>:<port>
    ```

---

### Step 12 - Rolling Restart

- If we deploy using `imagePullPolicy: always` set in the `YAML` file, we can use `rollout restart` to force `K8S` to grab the latest image.
- **This is the fastest restart method these days**

```bash
kubectl rollout restart deployment [deployment_name]
```
