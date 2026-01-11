# 🔐 Block All Websites and Allow Exceptions in Firefox in Active Directory 
### Using Group Policy on Windows Server 2025

## 📌 Overview
This repository provides a **step-by-step IT administration guide** to **block all websites** and **allow only selected websites** in **Mozilla Firefox** using **Group Policy (GPO)** on **Windows Server 2025**.

This configuration is useful for:
- Corporate environments 🏢  
- Educational institutions 🎓  
- Secure or restricted user environments 🔒  

The policy is managed centrally through **Active Directory Group Policy Management**.

---

## 🧰 Requirements
- Windows Server 2025
- Active Directory Domain Services (AD DS)
- Group Policy Management Console (GPMC)
- Mozilla Firefox (ADMX templates installed)
- Domain-joined client computers

---

## 🚫 Part 1: Block All Websites in Firefox Using Group Policy

### 🎯 Objective
To block access to **all websites** in Mozilla Firefox for domain users.

---

### 🪜 Steps

1. Go to the **Server Manager**
2. Click **Tools**
3. Select **Group Policy Management**
4. In the server name (eg: `adserver.local`)
5. Select an OU (eg: **Domain User**)  
   - Right click → **Create a GPO in this domain and link it here**

   a. **GPO Name**:  
        `Block All Websites and Allow Exceptions in Firefox`

   b. **Edit GPO**  
        ```
        Computer Configuration > Policies > Administrative Templates > Mozilla > Firefox
        ```

   c. Search for **“Block Websites”** and select it  

   d. **Enable** the policy  

   e. In **Options**, click **Show**  
      - To block all websites, enter:
        
      ```
      <all_urls>
      ```

   f. Click **OK** → **Apply**

6. Now all websites are successfully blocked in Firefox via GPO  

7. Apply the policy to the domain User  
   - Open **PowerShell** as Administrator and run:
     
       ```
      gpupdate /force
      ```



8. Test on a client computer  
- Open **PowerShell** as Administrator and run:

    ```
    gpupdate /force
    ````

9. Open **Firefox** and browse to any website (eg: Facebook, Google, Twitter)  
- A **“Blocked Page”** message will appear

---

## ✅ Part 2: Allow Only Selected Websites in Firefox

### 🎯 Objective
To allow access only to **approved websites** while keeping all other sites blocked.

---

### 🪜 Steps

1. Go to the **Server Manager**
2. Click **Tools**
3. Select **Group Policy Management**
4. In the server name (eg: `adserver.local`)
5. Select an OU (eg: **Domain User**)  
- Right click → **Create a GPO in the domain and link it here**

a. **GPO Name**:  
   `Block All Websites and Allow Exceptions in Firefox`

b. **Edit GPO**  
   ```
   Computer Configuration > Policies > Administrative Templates > Mozilla > Firefox
   ```

c. Search for **“Exceptions to Blocked Websites”**  
   - **Enable** it  

d. In **Options**, click **Show**  
   - Add allowed websites:
   ```
   *://*.facebook.com/*
   *://*.google.com/*
   *://*.twitter.com/*
   *://*.microsoft.com/*
   *://*.office365.com/*
   ```

e. Click **OK** → **Apply**

f. Selected websites are now unblocked in Firefox  

g. Apply the policy to the domain
* Open **PowerShell** as Administrator and run:
    
   ```
   gpupdate /force
   ```

h. Update policy on the client computer
* Open **PowerShell** as Administrator and run:
    
   ```
   gpupdate /force
   ```

i. Open **Firefox** and browse to allowed websites  
   - The websites will load successfully

---

## 🧪 Testing & Validation
- ❌ Non-listed websites should remain blocked  
- ✅ Only specified domains should be accessible  
- 🔁 Changes apply after `gpupdate /force`

---

 

## 🛡️ Security Note
Ensure Firefox **ADMX templates** are up to date and policies are tested in a **test OU** before deploying to production.

---


## ⭐ Contribution
Feel free to fork this repository, raise issues, or suggest improvements.

---
