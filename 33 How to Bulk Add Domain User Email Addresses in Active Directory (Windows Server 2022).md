# 📧 How to Bulk Add Domain User Email Addresses in Active Directory (Windows Server 2022)


## 📌 Overview

Managing user attributes individually in Active Directory can be time-consuming and inefficient, especially in environments with a large number of domain users. This document explains a **simple, built-in, and administrator-approved method** to **bulk add email addresses to multiple domain users** using **Active Directory Users and Computers (ADUC)** on **Windows Server 2022**.

This approach does **not require PowerShell or third-party tools**, making it ideal for:

* Small to medium enterprise environments
* Quick administrative updates
* Controlled domain attribute management

---

## 🎯 Use Case

This procedure is commonly used when:

* Configuring email attributes before Exchange / Microsoft 365 integration
* Standardizing email formats for domain users
* Performing initial domain user setup
* Correcting missing or empty email attributes in bulk

---

## 🧰 Prerequisites

Ensure the following before proceeding:

* Windows Server 2022
* Active Directory Domain Services (AD DS) installed
* Domain Administrator or delegated AD permissions
* Active Directory Users and Computers (ADUC) console access

---

## 🪜 Step-by-Step Procedure

### 🔹 Step 1: Open Server Manager

1. Log in to the domain controller
2. Open **Server Manager**

---

### 🔹 Step 2: Open Active Directory Tools

3. Navigate to **Group Policy Management** (if required for context)
4. Open **Active Directory Users and Computers**

---

### 🔹 Step 3: Select the Domain

5. Select your domain name (example):

```
adserver.local
```

---

### 🔹 Step 4: Navigate to the Target OU

6. Browse to the Organizational Unit (OU) containing the users

**Example:**

```
Domain_Users
```

---

### 🔹 Step 5: Verify Existing Email Attribute

7. Select an individual user
8. Right-click → **Properties**
9. Open the **General** tab
10. Verify that the **E-mail** field is empty

This confirms that the attribute has not already been populated.

---

## 🚀 Bulk Email Assignment Process

### 🔹 Step 6: Select Multiple Users

11. Select multiple users within the OU
12. Right-click → **Properties**

---

### 🔹 Step 7: Configure Email Attribute

13. Locate the **E-mail** field
14. Check the box to enable editing
15. Enter the following format:

```
%UserName%@companyemail.com
```

> 🔎 `%UserName%` dynamically maps each user’s **sAMAccountName** to generate a unique email address automatically.

---

### 🔹 Step 8: Apply Changes

16. Click **Apply**
17. Click **OK**

---

## ✅ Verification

### 🔹 Step 9: Confirm Individual User Records

18. Open any individual user account
19. Navigate to **Properties → General**
20. Confirm that the **E-mail** field is now populated correctly

---

## 📊 Example Result

| Username | Email Address                                               |
| -------- | ----------------------------------------------------------- |
| jdoe     | [jdoe@companyemail.com](mailto:jdoe@companyemail.com)       |
| asmith   | [asmith@companyemail.com](mailto:asmith@companyemail.com)   |
| rsharma  | [rsharma@companyemail.com](mailto:rsharma@companyemail.com) |

---

## 🏆 Best Practices & Notes

* ✔ Use standardized email naming conventions
* ✔ Perform changes during low-usage periods
* ✔ Validate user naming consistency before bulk actions
* ✔ Consider PowerShell for very large environments

---

## 🔐 Security Considerations

* Only authorized administrators should modify AD attributes
* Always verify the OU scope before applying bulk changes
* Test changes on a small user set before full deployment

---

## 📄 Documentation Metadata

* **Maintained by:** IT Department
* **Applies to:** Windows Server 2022
* **Directory Service:** Active Directory
* **Audience:** System Administrators / IT Support Engineers
* **Repository Type:** Internal / GitHub Documentation

---

