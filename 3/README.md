#  Infrastructure as Code: AWS Web Server (OpenTofu)

This folder provides an **OpenTofu (Terraform-compatible)** configuration to automatically provision a secure, lightweight **Ubuntu web server on AWS**.

The infrastructure is:
- Ephemeral (easy to destroy & recreate)
- Secure by default
- Fully automated

---

##  Prerequisites

Before running this project, ensure your environment is properly set up:

### 1. OpenTofu Installed
Make sure `tofu` is installed and available in your system PATH.

### 2. AWS CLI Configured
Install and authenticate AWS CLI using your IAM credentials:

```bash
aws configure
```

### 3. SSH Key Pair
You must have an RSA public key for secure access.

**Default path:**
```
C:/Users/YourUsername/.ssh/id_rsa.pub
```

>  Update this path in `variables.tf` if your key is stored elsewhere.

---

##  Project Structure

```
.
├── main.tf        # Core infrastructure (VPC, Security Group, EC2)
├── variables.tf   # Configurable variables (region, instance type, SSH key)
└── outputs.tf     # Outputs (e.g., public IP)
```

---

## Deployment Guide

### 1. Initialize the Workspace

```bash
tofu init
```

Downloads required providers and initializes state.

---

### 2. Preview Execution Plan (Optional)

```bash
tofu plan
```

Review what resources will be created before applying.

---

### 3. Apply Configuration

```bash
tofu apply
```

Type `yes` when prompted.

After completion, you’ll receive the **public IP** of your server.

---

## Accessing the Server

### Web Access

- Wait ~60 seconds for provisioning
- Open in browser:

```
http://<YOUR_PUBLIC_IP>
```

Expected output:

```html
<h1>Hello, Open Tofu on AWS (Ubuntu)!</h1>
```

---

### SSH Access

```bash
ssh ubuntu@<YOUR_PUBLIC_IP>
```

---

## Destroy Infrastructure

To avoid unnecessary AWS charges:

```bash
tofu destroy
```

Type `yes` to confirm.

This will:
- Terminate EC2 instance
- Delete Security Group
- Remove SSH key from AWS

---

## Architecture & DevOps Principles

###  Fast & Simple Deployment

- **Dynamic Lookups**
  - Automatically fetches:
    - Default VPC
    - Latest Ubuntu 22.04 AMI
  - No hardcoded IDs → portable across AWS accounts

- **Automated Bootstrapping**
  - Uses `user_data` to:
    - Update packages
    - Install Nginx
    - Start services automatically

---

### Security Best Practices

- **No Hardcoded Credentials**
  - Uses AWS CLI profile (`aws configure`)

- **SSH Key Authentication Only**
  - Password login disabled
  - Secure access via RSA public key

- **Minimal Network Exposure**
  - Security Group allows only:
    - Port 22 (SSH)
    - Port 80 (HTTP)
  - All other traffic is blocked

---

###  Idempotency & State Management

- OpenTofu ensures:
  - Consistent infrastructure state
  - Safe updates using execution plans
  - No configuration drift

---

###  Disaster Recovery

- Infrastructure is fully reproducible
- Treat servers as cattle, not pets

Recovery command:

```bash
tofu apply
```

 Rebuild time: ~2 minutes

---

###  Performance Optimization

- **Ubuntu 22.04 + Nginx**
  - Lightweight and efficient
  - Handles high concurrent traffic
  - Minimal memory usage

---

##  Summary

This project demonstrates:
- Infrastructure as Code (IaC)
- Secure cloud provisioning
- Automated server setup
