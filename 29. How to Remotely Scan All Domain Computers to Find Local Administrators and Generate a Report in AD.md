# How to Remotely Scan All Domain Computers to Find Local Administrators and Generate a Report in Active Directory


## Document Purpose

This document provides a standardized procedure for **remotely scanning all domain-joined computers** in an Active Directory environment to identify **local Administrators group members** and generate a centralized report for auditing and security review purposes.

---

## Target Audience

* IT Department
* System Administrators
* Network Administrators
* Information Security Team

---

## Prerequisites

* Active Directory Domain Environment
* Administrative privileges on domain computers
* PowerShell executed with **Run as Administrator**
* ActiveDirectory PowerShell module installed
* WMI and RPC communication allowed on target computers

---

## Step-by-Step Procedure

### Step 1: Open PowerShell with Administrative Privileges

**Open powershell run as admin**
And type the following command in powershell.

---

### Step 2: Import Active Directory Module

```powershell
Import-Module ActiveDirectory
```

This command loads the Active Directory module required to query domain computers.

---

### Step 3: PowerShell Script to Scan Local Administrators

Copy and paste the complete script below into the PowerShell window:

```powershell
$Computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name
$Report = @()

foreach ($Computer in $Computers) {

    # Check if device is online
    if (-not (Test-Connection -ComputerName $Computer -Count 1 -Quiet)) {
        $Report += [PSCustomObject]@{
            ComputerName  = $Computer
            AccountName   = "Offline"
            AccountSource = "Offline"
        }
        continue
    }

    try {
        $Admins = Get-WmiObject -Class Win32_GroupUser -ComputerName $Computer -ErrorAction Stop |
        Where-Object { $_.GroupComponent -like '*"Administrators"' }

        foreach ($Admin in $Admins) {

            $Account = ($Admin.PartComponent -split 'Name=')[1].Replace('"','')
            $Domain  = ($Admin.PartComponent -split 'Domain=')[1].Split(',')[0].Replace('"','')

            if ($Domain -eq $Computer) {
                $Source = "Local Account"
            }
            else {
                $Source = "Domain Account"
            }

            $Report += [PSCustomObject]@{
                ComputerName  = $Computer
                AccountName   = "$Domain\$Account"
                AccountSource = $Source
            }
        }
    }
    catch {
        $Report += [PSCustomObject]@{
            ComputerName  = $Computer
            AccountName   = "RPC / WMI Blocked"
            AccountSource = "Error"
        }
    }
}

$Report | Export-Csv "C:\Local_Admin.csv" -NoTypeInformation -Encoding UTF8
$Report
```

---

## Script Explanation (For IT Reference)

* Retrieves all computers from Active Directory
* Checks if each computer is online
* Queries the **local Administrators group** using WMI
* Identifies whether each account is:

  * Local Account
  * Domain Account
* Handles offline systems and RPC/WMI access errors
* Generates a structured report object
* Exports results to a CSV file

---

## Output and Result

**After a certain period of time it will success and show the result in powershell and as well as export the csv file in “C:\Local_Admin.csv”**

### Output Details:

* On-screen PowerShell table output
* CSV file saved at:

  ```
  C:\Local_Admin.csv
  ```

The CSV file can be used for:

* Security audits
* Privileged access reviews
* Compliance reporting
* Management review

---

## Notes and Best Practices

* Script execution time depends on the number of domain computers
* Ensure firewall rules allow WMI and RPC traffic
* Run during off-peak hours in large environments
* Review and restrict unnecessary local administrator accounts regularly

---
