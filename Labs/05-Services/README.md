
# K8S Hands-on


---

## Service Discovery

- In the following lab we will learn what is a `Service` and go over the different `Service` types.

---
### Prerequisites
- K8S cluster - <a href="../00-VerifyCluster">Setting up minikube cluster instruction</a>

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ide.cloud.google.com/?cloudshell_git_repo=https://github.com/nirgeier/KubernetesLabs)  
**<kbd>CTRL</kbd> + <kbd>click</kbd> to open in new window**

---

## Some general notes on what is a `Service`


- `Service` is a unit of application behavior bound to a unique name in a `service registry`. 
- `Service` consist of multiple `network endpoints` implemented by workload instances running on pods, containers, VMs etc.
- `Service` allow us to gain access to any given pod or container (e.g., a web service).
- A `service` is (normally) created on top of an existing deployment and exposing it to the "world", using IP(s) & port(s).
- `K8S` define 3 main ways (+FQDN internally) to define a service, which means that we have 4 different ways to access Pods.
- There are several proxy mode which implements different behaviour, for example in `user proxy mode` for each `Service` `kube-proxy` opens a port (randomly chosen) on the local node. Any connections to this "proxy port" are proxied to one of the Service's backend Pods (as reported via Endpoints).
- All the service types are assigned with a `Cluster-IP`.
- Every service also creates `Endpoint(s)`, which point to the actual pods. `Endpoints` are usually referred to as `back-ends` of a particular service.

---

### Step 01 - Create namespace and clear previous data if there is any

**If the namespace already exists, let's clean it**
```bash
kubectl delete namespace codewizard
```

**Create the desired namespace [codewizard]**
```bash
kubectl create namespace codewizard
```
!!! success "Expected Result"
    ```text
    namespace/codewizard created
    ```

---

### Step 02 - Create the required resources for this hand-on

**Network tools pod**
```bash
kubectl create deployment -n codewizard multitool --image=praqma/network-multitool
```

---

## Service types

- As previously mentioned, there are several services type. Let's practice them:

### Service type: ClusterIP

- If not specified, the default service type is `ClusterIP`.
- In order to expose the deployment as a service, use: `--type=ClusterIP`
- `ClusterIP` will expose the pods within the cluster. Since we don't have an `external IP`, it will not be reachable from outside the cluster.
- When the service is created `K8S` attaches a DNS record to the service in the following format: `<service name>.<namespace>.svc.cluster.local`

---

### Step 03 - Expose the nginx with ClusterIP

**Expose the service on port 80**
```bash
kubectl expose deployment nginx -n codewizard --port 80 --type ClusterIP
```

**Check the services**
```bash
kubectl get services -n codewizard
```
!!! success "Expected Result"
    ```text
    NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)
    nginx        ClusterIP   10.109.78.182   <none>        80/TCP
    ```

---

### Step 04 - Test the nginx with ClusterIP

- Since the service is a `ClusterIP`, we will test if we can access the service using the multitool pod.

**Get the name of the multitool pod**
```bash
kubectl get pods -n codewizard
```

**Run an interactive shell**
```bash
kubectl exec -it <pod name> -n codewizard -- sh
```

- Connect to the service in **any** of the following ways:

#### Test the nginx with ClusterIP

##### 1. using the IP from the services output. grab the server response:

```bash
curl -s <ClusterIP>
```
!!! success "Expected Result"
    ```html
    <!DOCTYPE html>
    <html>
    ...
    <h1>Welcome to nginx!</h1>
    ...
    </html>
    ```

<br>

##### 2. Test the nginx using the deployment name - using the service name since its the DNS name behind the scenes

```bash
curl -s nginx
```
!!! success "Expected Result"
    ```html
    <!DOCTYPE html>
    <html>
    ...
    </html>
    ```

<br>

##### 3. using the full DNS name - for every service we have a full `FQDN` (Fully qualified domain name) so we can use it as well

```bash
curl -s nginx.codewizard.svc.cluster.local
```

---

# Service type: NodePort

- `NodePort`: Exposes the Service on each Node's IP at a **static port** (the `NodePort`).
- A `ClusterIP` Service, to which the `NodePort` Service routes, **is automatically created**.
- `NodePort` service is reachable from outside the cluster, by requesting `<Node IP>:<Node Port>`.

### Step 05 - Create NodePort

##### 1. Delete previous service

```bash
kubectl delete svc nginx -n codewizard
```
!!! success "Expected Result"
    ```text
    service "nginx" deleted
    ```

<br>

##### 2. Create `NodePort` service

**Create NodePort service**
```bash
kubectl expose deployment -n codewizard nginx --port 80 --type NodePort
```

**Verify service**
```bash
kubectl get svc -n codewizard
```
!!! success "Expected Result"
    ```text
    NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)
    nginx        NodePort    100.65.29.172  <none>        80:32593/TCP
    ```
<br>

##### 3. Test the `NodePort` service

- If we have the host IP and the node port number, we can connect directly to the pod.

- If you followed the previous labs, you should be able to do it yourself by now......

```bash
kubectl cluster-info
kubectl get services -n codewizard
```
!!! success "Expected Result"
    ```text
    Welcome to nginx!
    ...
    Thank you for using nginx.
    ```

---


# Service type: LoadBalancer



!!! warning "Note"
    **We cannot test a `LoadBalancer` service locally on a localhost, but only on a cluster which can provide an `external-IP`**



### Step 06 - Create LoadBalancer (only if you are on real cloud)

<br>

##### 1. Delete previous service

```bash
kubectl delete svc nginx -n codewizard
```
!!! success "Expected Result"
    ```text
    service "nginx" deleted
    ```

<br>
<br>

##### 2. Create `LoadBalancer` Service

**Create LoadBalancer Service**
```bash
kubectl expose deployment nginx -n codewizard --port 80 --type LoadBalancer
```

**Verify service**
```bash
kubectl get svc -n codewizard
```
!!! success "Expected Result"
    ```text
    NAME         TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)
    nginx        LoadBalancer   100.69.15.89   35.205.60.29  80:31354/TCP
    ```
<br>

##### 3. Test the `LoadBalancer` Service

```bash
curl -s <EXTERNAL-IP>
```
