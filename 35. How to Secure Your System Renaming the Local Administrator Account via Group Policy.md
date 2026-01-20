# 🔒 How to Secure Your System: Renaming the Local Administrator Account via Group Policy

## 📌 Overview

Renaming the default Local Administrator account is a **critical security best practice** to prevent unauthorized access and reduce exposure to attacks. This document provides a step-by-step guide to securely rename the Local Administrator account using **Group Policy** in a **Windows Server 2022 Active Directory environment**.

This centralized approach ensures:

* Consistent security settings across all domain computers
* Reduced risk of brute-force attacks targeting the default Administrator account
* Auditable and repeatable administrative procedures

---

## 🧰 Prerequisites

Before applying this policy, ensure:

* Windows Server 2022 domain controller
* Group Policy Management Console (GPMC) access
* Domain Administrator or delegated GPO permissions
* Target computers are joined to the domain
* PowerShell administrative access

---

## 🪜 Step-by-Step Procedure

### 🔹 Step 1: Open Group Policy Management

1. Open **Server Manager**
2. Click **Tools → Group Policy Management**
3. Select your domain (example):

```
adserver.local
```

4. Select the target Organizational Unit (OU)

**Example:**

```
Domain_Users
```

### 🔹 Step 2: Create and Link a New GPO

5. Right-click the OU → **Create a new GPO and link it here**
6. Name the GPO:

```
Renaming the Local Administrator Account
```

7. Right-click the GPO → **Edit**

---

### 🔹 Step 3: Configure the Local Administrator Renaming Policy

8. Navigate to:

```
Computer Configuration → Policies → Windows Settings → Security Settings → Local Policies → Security Options → Accounts: Rename Administrator account
```

9. Right-click → **Properties**
10. Tick **Define this policy setting** and enter the new name:

```
systemadmin
```

11. Click **Apply → OK**

---

### 🔹 Step 4: Update Local Users Settings

12. Navigate to:

```
User Configuration → Preferences → Control Panel Settings → Local Users and Groups
```

13. Create a **New → Local User** configuration with the following settings:

* **Action:** Update
* **User Name:** systemadmin
* **Tick:** Account never expires

14. Click **Apply → OK**

---

### 🔹 Step 5: Apply the Policy

15. Open **PowerShell as Administrator** on the server
16. Run:

```
gpupdate /force
```

17. On a domain-joined client computer, open **PowerShell as Administrator**
18. Run:

```
gpupdate /force
```

19. Reboot the client computer to apply changes

---

### 🔹 Step 6: Verification

20. Open **Computer Management → Local Users and Groups → Users**
21. Confirm the Administrator account is now renamed to:

```
systemadmin
```

22. The account should have **never expires** status enabled

> ✅ The default Administrator account has been successfully renamed and configured.

---

## 🏆 Best Practices & Notes

* ✔ Always test the GPO on a small OU before broad deployment
* ✔ Document the new administrator name for IT staff
* ✔ Consider combining this with account renaming and password policy enforcement
* ✔ Monitor event logs to ensure no login issues occur

---

## 🔐 Security Considerations

* Changing the default Administrator name significantly reduces brute-force attack risks
* Only authorized administrators should modify the GPO
* Keep a record of renamed accounts for audit and emergency recovery

---

## 📄 Documentation Metadata

* **Maintained by:** IT Department
* **Applies to:** Windows Server 2022
* **Configuration Type:** Group Policy (Computer Configuration)
* **Audience:** System Administrators / IT Security Team
 
---

 
