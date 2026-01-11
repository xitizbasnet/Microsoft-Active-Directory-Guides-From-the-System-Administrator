
# Adding a Secondary Domain Controller (DC02) to Active Directory Domain (DC01)

## Overview
This guide walks you through the step-by-step process of adding a second Domain Controller (DC02) to your existing Active Directory Domain (DC01: `xitiztechservices.local`).

By the end, you'll have:
- A fully functional secondary Domain Controller.
- Active Directory replication between DC01 and DC02.
- High availability for authentication and directory services.

---

## Pre-Requisites

| Requirement      | Description                                                        |
|------------------|--------------------------------------------------------------------|
| **DC01**         | Primary Domain Controller (`xitiztechservices.local`)              |
| **DC02**         | Windows Server 2016/2019/2022 (Not yet promoted)                   |
| **Admin Access** | Required on both servers                                           |
| **Static IP**    | Set on DC02                                                        |
| **DNS Config**   | DC02 should point to DC01 for DNS                                  |
| **Network**      | Both servers must be able to ping each other                       |

---

## Step-by-Step: Adding DC02 as a Secondary Domain Controller

---

### Step 1: Configure DC02’s IP & DNS Settings

1. Open: `Control Panel > Network and Sharing Center > Change adapter settings`
2. Right-click your **Ethernet adapter** → Properties
3. Select **Internet Protocol Version 4 (TCP/IPv4)** → Properties
4. Set a static IP like:
   - IP Address: `192.168.1.20`
   - Subnet Mask: `255.255.255.0`
   - Gateway: `192.168.1.1`
   - Preferred DNS: `192.168.1.10` *(IP of DC01)*
5. Click **OK** and close all windows.

---

### Step 2: Join DC02 to the Domain

1. Open **Server Manager**
2. Navigate to: `Local Server > Computer Name`
3. Click **Change**
4. Select **Domain**, and enter:  
   `xitiztechservices.local`
5. Click **OK**
6. Enter **domain admin credentials** when prompted
7. Reboot the server when prompted

---

### Step 3: Install Active Directory Domain Services (AD DS) on DC02

1. Open **Server Manager**
2. Click: `Manage > Add Roles and Features`
3. Choose: **Role-based or feature-based installation**
4. Select **DC02** as the target server
5. Check: `Active Directory Domain Services`
6. Click **Add Features** when prompted
7. Click **Next** → Install (Don’t reboot yet)

---

### Step 4: Promote DC02 to a Domain Controller

1. After installation, click:  
   `Promote this server to a domain controller`
2. In the wizard:
   - Choose: **Add a domain controller to an existing domain**
   - Domain: `xitiztechservices.local`
   - Enter credentials if prompted
3. On next screen:
   - Check:
     - `Domain Name System (DNS) server`
     - `Global Catalog (GC)`
   - Set **DSRM password** (store securely)
4. Click **Next** through the rest
   - Replication: Use defaults (from DC01)
5. Click **Install**
   - DC02 will **reboot automatically**

---

### Step 5: Verify DC02 as Domain Controller

After reboot:

1. Log in using **domain credentials**
2. Open **Server Manager**
3. Go to: `Tools > Active Directory Users and Computers`
   - Confirm domain: `xitiztechservices.local`
4. Go to: `Tools > Active Directory Sites and Services`
   - Ensure **DC02** appears in the list

---

### Step 6: Check Replication Health (Optional but Recommended)

Run these commands in **Command Prompt (Admin)**:

```bash
repadmin /replsummary
````

* You should see **successful replication** from DC01 to DC02.

Also check:

```bash
dcdiag
```

* Look for `Passed` results. Troubleshoot any errors shown.

---

## Success! DC02 is Now a Backup Domain Controller

DC02 is now:

* A fully functioning backup domain controller.
* Able to authenticate users and replicate AD data.
* Ready to take over if DC01 fails.

---

## Optional Next Steps

* [ ] Add **DHCP/DNS roles** to DC02 for redundancy
* [ ] Set up **regular backups**
* [ ] Use **Group Policy Management** from either DC
* [ ] Monitor with tools like **Event Viewer** or **Performance Monitor**
* [ ] Verify **SYSVOL replication** (automatic via DFS-R)

---

