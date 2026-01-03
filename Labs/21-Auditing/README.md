
# K8S Hands-on



---

# Auditing

### Prerequisites
- A running Kubernetes cluster (Minikube, Kind, or Cloud Shell).
- `kubectl` configured to access your cluster.

---

## Introduction to Auditing
Kubernetes auditing provides a security-relevant, chronological set of records documenting the sequence of activities that have affected the system by individual users, administrators, or other components of the system. It allows cluster administrators to answer the following questions:
- What happened?
- When did it happen?
- Who initiated it?
- On what resource did it happen?
- Where was it observed?
- From where was it initiated?
- To where was it going?

### Step 01 - Understanding Audit Policies
Audit policies define rules about what events should be recorded and what data they should include. The audit policy object structure is defined in the `audit.k8s.io` API group. 

### Step 02 - Example Audit Policy
A basic policy might look like this:
```yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: Metadata
```

### Step 03 - Enabling Auditing
To enable auditing, you must pass specific flags to the `kube-apiserver`:
- `--audit-policy-file`: Path to the file that defines the policy.
- `--audit-log-path`: Path to the log file where audit events will be written.

---
*Note: This is a placeholder for the full detailed walkthrough.*
