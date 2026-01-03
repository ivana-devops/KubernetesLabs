# K8S Hands-on


---

## DataStore (Volumes, PVC & PV)

## Secrets and ConfigMaps

- Secrets & ConfigMap are ways to store and inject configurations into your deployments.
- Secrets usually store passwords, certificates, API keys and more.
- ConfigMap usually store configuration (data).


---


### Prerequisites
- K8S cluster - <a href="../00-VerifyCluster">Setting up minikube cluster instruction</a>

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://ide.cloud.google.com/?cloudshell_git_repo=https://github.com/nirgeier/KubernetesLabs)  
**<kbd>CTRL</kbd> + <kbd>click</kbd> to open in new window**

---


# First, Let's play a bit with Secrets

### Step 01 - Create namespace and clear previous data (if there is any)

```bash
# If the namespace already exists, let's clean it
kubectl delete namespace codewizard

# Create the desired namespace [codewizard]
kubectl create namespace codewizard
```
!!! success "Expected Result"
    ```text
    namespace/codewizard created
    ```

!!! warning "Note"
    **You can skip section number 02. if you don't wish to build and push your docker container**

---

### Step 02 - Build the docker container

##### 1. write the server code
- For this demo we will use a tiny NodeJS server which will consume the desired configuration values from the secret
- This is the code of our server [server.js](./resources/server.js):

```js
//
// server.js
//
const 
  // Get those values in runtime.
  // The variables will be passed from the Docker file and later on from K8S ConfigMap/Secret
  language = process.env.LANGUAGE,
  token = process.env.TOKEN;

require("http")
  .createServer((request, response) => {
    response.write(`Language: ${language}`);
    response.write(`Token   : ${token}\n`);
    response.end(`\n`);
  })
  // Set the default port to 5000
  .listen(process.env.PORT || 5000 );
```

<br>


##### 2. Write the DockerFile

- First, let's wrap it up as `docker container`
- If you wish, you can skip this and use the existing docker image: `nirgeier/k8s-secrets-sample`
- In the `Dockerfile` we will set the `ENV` for or variables

```Dockerfile
# Base Image
FROM        node

# exposed port - same port is defined in the server.js
EXPOSE      5000

# The "configuration" which we pass in runtime
# The server will "read" those variables at run time and will print them out
ENV         LANGUAGE    Hebrew
ENV         TOKEN       Hard-To-Guess

# Copy the server to the container
COPY        server.js .

# start the server
ENTRYPOINT  node server.js
```

<br>

##### 3. Build the docker container
```bash
# Replace the prefix with your Dockerhub account
docker build . -t nirgeier/k8s-secrets-sample
```
!!! success "Expected Result"
    ```text
    Successfully built f5cbb1895d66
    Successfully tagged nirgeier/k8s-secrets-sample:latest
    ```

<br>

##### 4. Test the container

```bash
# Run the container
docker run -d -p5000:5000 --name server nirgeier/k8s-secrets-sample

# Test the response
curl 127.0.0.1:5000
```
!!! success "Expected Result"
    ```text
    Language: Hebrew
    Token   : Hard-To-Guess
    ```

<br>

- Stop the container

```bash
docker stop server
```
!!! success "Expected Result"
    ```text
    server
    ```

- Push the container to your docker hub account if you wish

---


### Step 03 - Using K8S deployment & Secrets/ConfigMap

##### 1. Writing the deployment & service file

- Deploy the docker container that you have prepared in the previous step with the following `Deployment` file.
- In this sample we will define the values in the `YAML` file, later on we will use Secrets/ConfigMap [variables-from-yaml.yaml](./resources/variables-from-yaml.yaml)

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: codewizard
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secrets-app
  namespace: codewizard
spec:
  replicas: 1
  selector:
    matchLabels:
      name: secrets-app
  template:
    metadata:
      labels:
        name: secrets-app
    spec:
      containers:
        - name: secrets-app
          image: nirgeier/k8s-secrets-sample
          imagePullPolicy: Always
          ports:
            - containerPort: 5000
          env:
            - name: LANGUAGE
              value: Hebrew
            - name: TOKEN
              value: Hard-To-Guess2
          resources:
            limits:
              cpu: "500m"
              memory: "256Mi"
---
apiVersion: v1
kind: Service
metadata:
  name: codewizard-secrets
  namespace: codewizard
spec:
  selector:
    app: codewizard-secrets
  ports:
    - protocol: TCP
      port: 5000
      targetPort: 5000
```
<br>

##### 2. Deploy to cluster
```bash
kubectl apply -n codewizard -f variables-from-yaml.yaml
```
!!! success "Expected Result"
    ```text
    deployment.apps/codewizard-secrets configured
    service/codewizard-secrets created
    ```
<br>

##### 3. Test the app

- We will need a second container for executing the curl request.
- We will use a `busyBox image` for this purpose.

**Get the pod name**
```bash
kubectl get pods -n codewizard
```

**Login and test**
```bash
kubectl exec -it -n codewizard <pod name> -- sh
curl localhost:5000
```
!!! success "Expected Result"
    ```text
    Language: Hebrew
    Token   : Hard-To-Guess2
    ```

---

### Step 04 - Using Secrets & config maps

##### 1. Create the desired secret and config map for this lab

**Create Secret**
```bash
kubectl create -n codewizard secret generic token --from-literal=TOKEN=Hard-To-Guess3
```

**Create ConfigMap**
```bash
kubectl create -n codewizard configmap language --from-literal=LANGUAGE=English
```

**Verify**
```bash
kubectl get secrets,cm -n codewizard
kubectl describe secret token -n codewizard
kubectl describe cm language -n codewizard
```

<br>

##### 2. Update the deployment to read the values from Secrets & ConfigMap

- Change the `env` section to the following:

```yaml
          env:
            - name: LANGUAGE
              valueFrom:
                configMapKeyRef:    # This value will be read from the config map
                  name:   language  # The name of the ConfigMap
                  key:    LANGUAGE  # The key in the config map
            - name: TOKEN
              valueFrom:
                  secretKeyRef:         # This value will be read from the secret
                      name:   token     # The name of the secret
                      key:    TOKEN     # The key in the secret
```

<br>

##### 3. Update the deployment to read values from K8S resources

```bash
kubectl apply -n codewizard -f variables-from-secrets.yaml
```
!!! success "Expected Result"
    ```text
    deployment.apps/codewizard-secrets configured
    service/codewizard-secrets unchanged
    ```
<br>

##### 4. Test the changes


- Refer to [step 3.3](#3-test-the-app) for testing your server

  ```bash
# Replace with your actual pod name
kubectl exec -it <pod_name> -n codewizard -- sh
curl localhost:5000
```
!!! success "Expected Result"
    ```text
    Language: English
    Token   : Hard-To-Guess3
    ```

---

<br>

!!! warning "Note"
    Pods are not recreated or updated automatically when `Secrets` or `ConfigMaps` change, so you will have to restart your pods manually

- To update existing secrets or ConfigMap:

```bash
kubectl create secret generic token -n codewizard --from-literal=Token=Token3 -o yaml --dry-run=client | kubectl replace -f -
```

- Test your server and verify that you see the old values.
- Delete the old pods so they can come back to life with the new values.
- Test your server again, now you should be able to see the changes.

