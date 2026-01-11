# 🔐 Auto-Connect Domain Computers to Wi-Fi using EAP-TLS (Group Policy)

Enterprise-ready documentation for configuring **password-less Wi-Fi authentication** for domain-joined computers using **EAP-TLS certificates**, **Active Directory Certificate Services (AD CS)**, **Network Policy Server (NPS)**, and **Group Policy**.

---

## 📘 Overview

This repository documents a **secure, scalable, and centralized** approach to automatically connect domain computers to an enterprise Wi-Fi network **without using shared passwords**.

Authentication is performed using **machine certificates (EAP-TLS)** issued via Active Directory Certificate Services and enforced through Group Policy.

---

## 🏢 Environment

| Component             | Details                     |
| --------------------- | --------------------------- |
| Domain Name           | `abc.company.local`         |
| Authentication        | EAP-TLS (Certificate-based) |
| Wi-Fi Security        | WPA / WPA2-Enterprise       |
| Certificate Authority | AD CS (Enterprise Root CA)  |
| RADIUS                | Network Policy Server (NPS) |

---

## 🎯 Objectives

* Eliminate shared Wi-Fi passwords
* Enforce certificate-based authentication
* Automatically enroll certificates for domain computers
* Centrally manage Wi-Fi connectivity via Group Policy
* Improve enterprise Wi-Fi security posture

---

## 🧩 Architecture Flow

```
Domain Computer
   ↓ (Auto-Enroll Certificate via GPO)
Active Directory Certificate Services
   ↓ (EAP-TLS Authentication)
Network Policy Server (NPS)
   ↓ (RADIUS)
Wi-Fi Router / Access Point
```

---

## 🛠️ Prerequisites

* Windows Server with Active Directory Domain Services
* Administrative access to Domain Controller
* Network Policy Server installed
* Enterprise Wi-Fi Router / Access Point with RADIUS support
* Domain-joined Windows client machines

---

## ⚙️ Implementation Guide

### Step 1: Install and Configure Active Directory Certificate Services (AD CS)

**Domain Controller:** `abc.company.local`

1. Open **Server Manager**
2. Go to **Add Roles and Features**
3. Select **Role-based or feature-based installation**
4. Choose **Select a server from the server pool**
5. Install the following roles:

   * **Active Directory Certificate Services** → Add Features
   * **Network Policy and Access Services** → Add Features
   * **Certification Authority**
6. Complete installation

#### Configure AD CS

1. Select **Configure Active Directory Certificate Services on the destination server**
2. Choose **Certification Authority**
3. Select **Enterprise CA**
4. Select **Root CA**
5. Create a **New Private Key**
6. Cryptographic settings:
   * Provider: `RSA#Microsoft Software Key Storage Provider`
   * Key Length: `2048`
   * Hash Algorithm: `SHA256`
7. Complete configuration

---

### Step 2: Create Certificate Template for Auto-Enrollment

1. Open **Certification Authority(Local)** → **Certificate Templates** → Right Click **Manage**
2. Select **Computer**  > Right Click > **Dublicate Template**

**Template Configuration**

* Select on **General**  → **Template Display Name:** `wifi-cert`
* **Validity Period:** 2 Years
  
* Select on **Security Handling**  → **Purpose:** Signature and Encryption
* Enabled  → **Allow private key to be exported:**

* Select on **Security Tab**  → `Domain Computers`

  * Read
  * Enroll
  * Autoenroll

* Select on **Subject Name**  → DNS Name

* Select on **Extensions**  

  * Client Authentication
  * Server Authentication

✅ Template appears as **Wifi-Cert**

---

### Step 3: Configure Network Policy Server (NPS)

#### Register NPS

1. Open **Network Policy Server**
2. Right-click **NPS (Local)** → **Register server in Active Directory**

#### Configure RADIUS Client

* **Friendly Name:** My Wifi
* **Address:** `192.168.1.1` (Router Gateway IP) → Verify → Resolve
* **Shared Secret:** Configured between NPS and Access Point

#### Create Network Policy

* **Policy Name:** My Wifi Policy
* **Condition:** Windows Group → `Domain Computers`
* Select on **Access Granted** 
* **EAP Type:** Add → Microsoft Smart Card or other Certificate (EAP-TLS)

---

### Step 4: Enable Certificate Auto-Enrollment via Group Policy

#### Create GPO

* **GPO Name:** WiFi EAP TLS Enrollment
* Linked to: **Computer Accounts OU** (or required OU)

#### Configure Auto-Enrollment

```
Computer Configuration
 → Policies
  → Windows Settings
   → Security Settings
    → Public Key Policies
      → Automatic Certificate Request Setting > New > Automatic Certificate Request > Computer
        → Finish
```

* Select on **Certificate Services Client – Auto-Enrollment**  → Enable
* Enable:
  * Renew expired certificates, Update pending certificates, Remove revoked certificates
  * Update certificates that use certificate templates
---

### Step 5: Configure Wireless Network Policy (GPO)

* Select on **Wireless network (IEEE 802.11) policies** > right click and select **create a new wireless network policy for windows vista and later releases**
* **Policy name**: TPlink_Wifi
* Under the **Profile Name** > Add > Infrastructure
* **Network SSID:** TPlink_Wifi > Add
* Select on **Connection Mode:** Connect even if not broadcasting
* Select on **Security Tab**  → **Network Authentication:** WPA2-Enterprise
* **Network Authentication Method:** Microsoft Smart Card or other Certificate (EAP-TLS)
* **Authentication Mode:** Computer Authentication
* Select on **Trusted Root CA:** Company-ADC-2025CA

---

### Step 6: Router / Access Point Configuration

| Setting          | Value                 |
| ---------------- | --------------------- |
| SSID             | TPlink_Wifi           |
| Security         | WPA / WPA2-Enterprise |
| RADIUS Server IP | 192.168.1.201         |
| RADIUS Port      | 1812                  |
| Shared Secret    | password@123          |

---

### Step 7: Domain Verification

CMD: Run as an administrator
```cmd
gpupdate /force
```

### Step 8: Client Verification

CMD: Run as an administrator
```cmd
gpupdate /force
```

1. Restart the domain computer
2. Open `certlm.msc`
3. Verify certificate under **Personal → Certificates**
4. Open **Wi-Fi**  → Select **TPlink_Wifi**
5. Device connects automatically without a password

---

## ✅ Result

Domain-joined computers securely authenticate to enterprise Wi-Fi using **certificate-based EAP-TLS**, ensuring:

* Strong security
* Zero password exposure
* Centralized management
* Seamless user experience

---

## ✍️ Author

**Xitiz Basnet – System Administration**

---

