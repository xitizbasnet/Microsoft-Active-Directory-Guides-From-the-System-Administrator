# 🚫 Deny Domain Users from Copying Data to Mobile Devices Using Group Policy

> **Platform:** Windows Server 2025  
> **Policy Type:** User Configuration (GPO)  
> **Audience:** System Administrators / IT Department  

---

## 📘 Overview

This document describes a **secure and standardized method** to prevent **domain users** from copying data from **domain-joined computers** to **mobile devices** (smartphones, tablets, media players) using **Group Policy Objects (GPO)** in **Windows Server 2025**.

By enforcing this policy, organizations can reduce the risk of:

* 🔐 Data leakage
* 📱 Unauthorized mobile data transfers
* 📂 Accidental file exfiltration

---

## 🎯 Objective

To **deny write access** to **Windows Portable Devices (WPD)** so that users **cannot copy, paste, or drag-and-drop files** from computers to connected mobile devices.

---

## 🧭 Scope

* ✔ Windows Server 2025 (Active Directory)
* ✔ Domain-joined Windows client machines
* ✔ Applies to **Domain Users** via Organizational Unit (OU)
* ❌ Does *not* affect USB flash drives unless separately configured

---

## 🛠 Prerequisites

* 🖥 Active Directory Domain Services (AD DS)
* 🧩 Group Policy Management Console (GPMC)
* 👤 Domain User accounts organized into an OU (e.g., `Domain_User`)
* 🔑 Domain Administrator or equivalent privileges

---

## 🧱 Step-by-Step Configuration

### 🖥️ Server-Side Configuration (Group Policy)

1. **Open Server Manager**
2. Navigate to **Group Policy Management**
3. Click on the Active Directory domain name

   * Example: `adserver.local`
4. Select the target **Organizational Unit (OU)**

   * Example: `Domain_User`
5. **Right-click** the OU and select **Create a GPO in this domain, and Link it here**
6. Set the GPO name as:

   ```
   Deny Domain Users To Copy Data from Computer to Mobile
   ```
7. Right-click the newly created GPO and click **Edit**

---

### ⚙️ GPO Policy Path Configuration

Navigate to the following path:

```
User Configuration
 └─ Policies
   └─ Administrative Templates Policy defination(ADM)
      └─ System
         └─ Removable Storage Access
```

Locate the policy:

🔒 **WPD Devices: Deny write access**

* Set the policy to **Enabled**
* Click **OK** to save changes

📌 **Impact:** This blocks all write operations to Windows Portable Devices.

---

### 🔄 Apply Group Policy on Server

Open **PowerShell** with **Run as Administrator** and execute:

```
gpupdate /force
```

---

## 💻 Client-Side Policy Update

1. Log in to a **domain-joined client computer** as a domain user
2. Open **PowerShell** → **Run as Administrator**
3. Execute:

```
gpupdate /force
```

---

## ✅ Verification & Testing

Perform the following actions on the client machine:

* 📂 Copy a file from **Desktop** or **Local Disk**
* 📱 Paste or drag the file to a connected **mobile device**

### 🔍 Expected Result

* ❌ File copy is **denied**
* ❌ Drag-and-drop is **blocked**
* ❌ Paste operation fails

This confirms the policy is working as intended.

---

## 🧠 Technical Notes

* **WPD (Windows Portable Devices)** includes:

  * Smartphones
  * Tablets
  * Media players connected via USB
* The restriction is applied at the **User Policy level**
* Policy enforcement occurs after user logon and GPO refresh

---

## 🧪 Troubleshooting

If the policy does not apply:

* 🧾 Run `gpresult /r` on the client to confirm GPO assignment
* 🔄 Ensure the user logs out and logs back in
* 🏷 Confirm the user account resides in the correct OU
* 🔌 Verify the device is detected as a **WPD device**, not USB mass storage

---

## ⭐ Best Practices

* 🧪 Test in a **pilot OU** before production rollout
* 📑 Maintain **change logs** for compliance and audits
* 🔐 Combine with **USB storage GPOs** for enhanced data protection
* 📁 Store this document in a **GitHub repository** for version control

---

## 🏁 Conclusion

This GPO configuration provides a **reliable and enterprise-grade control** to prevent data transfer from computers to mobile devices, strengthening organizational **data security posture**.

---

## 📄 Metadata

* **Document Owner:** IT Department
* **Applies To:** Domain Users
* **Server OS:** Windows Server 2025
* **Policy Category:** Data Loss Prevention (DLP – Basic)
* **Status:** Approved for Production Use
