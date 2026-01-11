# 🔐 How To Secure Your System

## Renaming the Local Administrator Account with Group Policy

![Active Directory](https://img.shields.io/badge/Active%20Directory-GPO-blue) ![Security](https://img.shields.io/badge/Security-Hardening-green) ![Windows](https://img.shields.io/badge/Platform-Windows-informational)

---

## 📘 Overview

In our domain user we all have the administrator account. For security reason we must change it. To change the account from administrator to sysadmin to the domain computer we can do it from the active directory.

Renaming the default **Administrator** account is a recommended security hardening practice. Attackers commonly target well-known account names, and changing this reduces the attack surface across domain-joined systems.

---

## 🎯 Objective

* Rename the built-in **Administrator** account to **sysadmin**
* Apply the configuration using **Group Policy (GPO)**
* Ensure the change is enforced across all domain computers

---

## 🧰 Prerequisites

* Windows Server with **Active Directory Domain Services**
* Group Policy Management Console (GPMC)
* Domain Administrator privileges
* Domain-joined client computers

---

## 🛠️ Server-Side Configuration (Group Policy)

Follow the steps below on the **Domain Controller**:

1. Go to **Server Manager**
2. Click **Tools**
3. Select **Group Policy Management**
4. Select the server name (eg: `adserver.local`)
5. Select OU (eg. **Domain user**)
6. Create a gpo in this domain, and linked it here
7. **NEW GPO Name:** `Renaming the Local Administrator Account to sysadmin`
8. Edit the gpo
9. Go to:

   ```
   Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > Security Options
   ```
10. Select **“Accounts: Rename administrator account”** > right click **Properties**
11. Enabled: **Define this policy setting**
12. Type: `sysadmin`
13. Click **Apply > OK**

---

## 👤 Local User Configuration via GPO

This ensures the renamed account is properly managed:

14. Go to:

```
User Configuration > Control Panel Settings > Local Users and Groups
```

15. Right click **New > Local User**
16. On **Action:** Update
17. **User name:** `sysadmin`
18. Click **Apply > OK**

---

## 🔄 Apply Group Policy on Server

19. Run **Command Prompt** as Administrator
20. Type:

```
gpupdate /force
```

---

## 💻 Client Computer Verification

Now go to the **client computer**:

 a. Run **Command Prompt** as Administrator
b. Type:

  ```
  gpupdate /force
  ```
c. Reboot the system

d. Open **Local Users and Groups**

e. Select **Users**

f. Now here we can see as user administrator has been changed to the **sysadmin**



---

## ✅ Result

✔ The default **Administrator** account is successfully renamed to **sysadmin**

✔ Policy is centrally enforced via Active Directory

✔ Security posture of domain computers is improved

---

## 📌 Security Notes & Best Practices

* Renaming the Administrator account should be combined with **strong passwords**
* Limit interactive logon for local admin accounts
* Monitor administrator account usage via **Event Logs**
* Test GPOs in a controlled OU before full deployment

---
