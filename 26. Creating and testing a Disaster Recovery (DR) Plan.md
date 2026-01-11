## ✅ Goals of DR Testing

* Verify **AD & DNS** can be recovered
* Confirm **critical roles/services** come back online
* Test **user authentication**, file access, GPOs, and M365 sync (if hybrid)
* Ensure **documentation and backups** are valid and usable
* Identify recovery time (RTO) and recovery point (RPO)

---

## 🧰 DR Testing Plan – Step by Step

---

### 📝 Step 1: Prepare Documentation

✅ Collect and validate:

| Item             | Example                                  |
| ---------------- | ---------------------------------------- |
| AD Topology Map  | Sites, Domain Controllers, FSMO roles    |
| Server Inventory | Name, IPs, Roles (DC, File, Print, DHCP) |
| Backup Strategy  | Veeam, Windows Backup, Acronis, etc.     |
| Contact List     | IT, vendors, cloud providers             |

---

### 🛑 Step 2: Define Scope of the DR Test

| Test Type            | What to Include                           |
| -------------------- | ----------------------------------------- |
| 🔄 Partial DR Test   | Recover 1 DC or a few services            |
| 💥 Full DR Test      | Assume total data center or site failure  |
| 🧪 Tabletop Test     | Dry run with team on paper                |
| 🔁 Restore-Only Test | Restore VMs from backup, isolated network |

---

### 🛠️ Step 3: Back Up Everything (Before Testing)

* AD System State (`wbadmin start systemstatebackup`)
* VM Snapshots of DCs and critical servers
* Export GPOs, DNS zones, DHCP config
* Export AD users (optional CSV via PowerShell)

---

### 🧪 Step 4: Test Recovery (Offline or Isolated)

> 🧪 **Use a test lab or isolated VLAN** if possible — never test DR on live systems without planning

---

#### ✅ AD Recovery Test

1. **Restore a Domain Controller** from backup (or clone)
2. Run `dcdiag` to check health
3. Check:

   * FSMO roles
   * `netlogon` and `sysvol` shared
   * DNS resolution working
   * `repadmin /replsummary`

---

#### ✅ DNS & DHCP Test

* Check DNS zone replication
* Restore DHCP database (`netsh dhcp server import/export`)
* Test client IP leasing and name resolution

---

#### ✅ Authentication Test

* Log in with test user
* Access shared drives, mapped printers
* Apply Group Policies

---

#### ✅ M365/Azure AD Sync Test (If Hybrid)

* Check `Azure AD Connect` status
* Run `Start-ADSyncSyncCycle -PolicyType Delta`
* Confirm new users or password changes sync

---

### ✅ Step 5: Document Findings

Create a **DR Test Report** including:

| Section               | Details                         |
| --------------------- | ------------------------------- |
| Date of test          | 📅                              |
| Team members involved | 👥                              |
| Services tested       | AD, DNS, DHCP, File Server, AAD |
| Time taken to recover | 🕒                              |
| Issues found          | ❌                               |
| Improvements needed   | ✅                               |

---

## 🚨 Optional: Test Scenarios to Simulate

| Scenario                     | What to Do                                     |
| ---------------------------- | ---------------------------------------------- |
| ❌ Accidental User Deletion   | Delete test user, recover using AD Recycle Bin |
| 🔌 Server Power Failure      | Power off test DC, see how failover behaves    |
| 💣 Ransomware on File Server | Restore from backup, verify file integrity     |
| 🌐 No Internet               | Test offline AD login, local resource access   |
| 💥 Total DC Failure          | Simulate restore from system state backup      |

---

## 📋 Tools That Help

| Tool                 | Use                               |
| -------------------- | --------------------------------- |
| Veeam / Acronis      | Backup & restore verification     |
| AD Recycle Bin       | Quick recovery of deleted objects |
| `wbadmin`            | Windows-native backup             |
| `dcdiag`, `repadmin` | AD health checks                  |
| Event Logs           | Troubleshooting failed restores   |

---

## ✅ Final Step: Update the DR Plan

After testing:

* Revise documentation
* Fix gaps found (e.g., missing DNS backup)
* Train team on exact recovery steps
* Schedule **quarterly** or **bi-annual** DR drills

---
