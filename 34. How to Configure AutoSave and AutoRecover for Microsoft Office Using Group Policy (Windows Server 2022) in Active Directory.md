# 💾 How to Configure AutoSave and AutoRecover for Microsoft Office Using Group Policy (Windows Server 2022) in Active Directory

## 📌 Overview

AutoSave and AutoRecover are critical Microsoft Office features that help prevent data loss due to unexpected shutdowns, application crashes, or power failures. By default, these settings are configured locally per user and can vary across systems.

This document explains how to **centrally configure and enforce AutoSave and AutoRecover settings** for **Microsoft Excel** using **Group Policy** in a **Windows Server 2022 Active Directory environment**.

This approach ensures:

* Consistent data protection across all domain users
* Reduced risk of data loss
* Centralized administrative control
* Compliance with enterprise IT standards

---

## 🎯 Use Case

This configuration is recommended when:

* Users frequently work on critical Excel documents
* Standardizing Office behavior across the organization
* Enforcing automatic background saving
* Preventing accidental data loss

---

## 🧰 Prerequisites

Before proceeding, ensure the following:

* Windows Server 2022 with Active Directory Domain Services (AD DS)
* Group Policy Management Console (GPMC)
* Microsoft Office / Excel 2016 or later (ADMX templates installed)
* Domain Administrator or delegated GPO permissions
* Client computers joined to the domain

---

## 🧪 Verify Default Excel Behavior (Optional)

Before applying Group Policy, it is recommended to verify the default setting.

1. Open **Microsoft Excel**
2. Go to **File → Options**
3. Select **Save**
4. Observe the option:

```
Save AutoRecover information every: 10 minutes
```

> ℹ️ **10 minutes** is the default AutoRecover interval.

---

## 🪜 Group Policy Configuration Steps

### 🔹 Step 1: Open Group Policy Management

6. Open **Server Manager**
7. Click **Tools**
8. Select **Group Policy Management**

---

### 🔹 Step 2: Select Domain and OU

9. Select your domain (example):

```
adserver.local
```

10. Select the target Organizational Unit (OU)

**Example:**

```
Domain_Users
```

---

### 🔹 Step 3: Create and Link a New GPO

11. Right-click the OU
12. Select **Create a GPO in this domain, and Link it here**
13. Name the GPO:

```
AutoSave and AutoRecover for Microsoft Office
```

---

### 🔹 Step 4: Edit the GPO

14. Right-click the newly created GPO and select **Edit**

Navigate to:

```
User Configuration
 └─ Policies
    └─ Administrative Templates
       └─ Microsoft Excel 2016
          └─ Excel Options
             └─ Save
```

---

## ⚙️ Configure AutoRecover Settings

### 🔹 Step 5: Enable AutoRecover Time

15. Open **Auto Recover Time**
16. Set it to **Enabled**
17. Configure:

```
Save AutoRecover info every: 3 minutes
```

18. Click **Apply** and **OK**

---

### 🔹 Step 6: Enable AutoSaved File Retention

19. Enable the following policy:

```
Keep the last AutoSaved versions of files for the next session
```

> 📝 This setting ensures files are automatically saved in the background, even if the user closes Excel without manually saving. The file will be available the next time Excel is opened.

---

## 🔄 Apply Group Policy Updates

### 🔹 Step 7: Update Group Policy on Server

20. Open **Command Prompt** as Administrator
21. Run:

```
gpupdate /force
```

---

### 🔹 Step 8: Update Group Policy on Client Computer

22. Log in to a domain-joined client computer
23. Open **Command Prompt** as Administrator
24. Run:

```
gpupdate /force
```

---

## ✅ Verification on Client System

### 🔹 Step 9: Confirm Policy Application

25. Open **Microsoft Excel** on the client computer
26. Navigate to:

```
File → Options → Save
```

27. Verify that:

```
Save AutoRecover information every: 3 minutes
```

✔ The option is **enabled and enforced** by Group Policy

---

## 🏆 Best Practices & Notes

* ✔ Always test GPOs on a pilot OU before production deployment
* ✔ Ensure correct Office ADMX templates are installed
* ✔ Use shorter AutoRecover intervals for critical data teams
* ✔ Avoid extremely low values that may affect performance

---

## 🔐 Security & Compliance Considerations

* GPO changes should follow change-management procedures
* Restrict GPO editing permissions
* Document changes for audit and rollback purposes

---

## 📄 Documentation Metadata

* **Maintained by:** IT Department
* **Applies to:** Windows Server 2022
* **Application:** Microsoft Excel / Office
* **Configuration Type:** Group Policy (User Configuration)
* **Audience:** System Administrators / IT Operations Team
* **Repository Type:** Internal / GitHub Documentation

---

