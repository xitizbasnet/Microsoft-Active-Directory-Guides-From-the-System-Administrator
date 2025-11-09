# 🕒 Change Time Zone on All Domain Computers Using Group Policy (Startup Script)

## 📘 Overview
This guide explains how to configure a **uniform time zone** across all domain-joined Windows computers using a **Group Policy Object (GPO)** with a **startup script**.  

Using this approach ensures:
- ✅ Consistent system time across all devices  
- 🧾 Accurate timestamps in event logs  
- ⏰ Reliable operation of scheduled tasks and time-sensitive applications  

---

## 🧰 Prerequisites
Before you begin, make sure you have:

| Requirement | Description |
|--------------|-------------|
| 🖥️ Windows Server | Domain Controller with Group Policy Management Console (GPMC) |
| 👤 Permissions | Domain Administrator rights |
| 💻 Client Systems | Windows 10 / 11 domain-joined devices |

---

## 🔍 Step 1 — Identify the Desired Time Zone

1. Open **Command Prompt** on any Windows computer.  
2. Run the following command to list all available time zones:

    ```
    tzutil /l
     ```
    
4. From the output, find and copy the **exact** name of your target time zone.
   Example:
   ```
   (UTC+05:45) Kathmandu
   Nepal Standard Time
   ```
---

## 🧾 Step 2 — Create the Time Zone Change Script

1. Open **Notepad**.
2. Paste the following command (replace the name with your selected time zone):

   ```cmd
   tzutil /s "Nepal Standard Time"
   ```
3. Save the file with a descriptive name and a `.bat` extension, e.g.:

   ```
   ChangeTimeZone.bat
   ```

   💡 **Tip:** Choose *Save as type:* “All Files” to avoid adding `.txt`.

---

## 🧩 Step 3 — Create and Link the GPO

1. Open **Group Policy Management Console (GPMC)**.
2. Right-click the **Organizational Unit (OU)** where you want to apply the policy.
3. Select:

   ```
   Create a GPO in this domain, and Link it here...
   ```
4. Name it something descriptive, e.g.:

   ```
   Change Time Zone
   ```
5. Click **OK**, then **right-click** the new GPO and choose **Edit**.

---

## ⚙️ Step 4 — Add the Startup Script

1. In the **Group Policy Management Editor**, navigate to:

   ```
   Computer Configuration
   └── Policies
       └── Windows Settings
           └── Scripts (Startup)
   ```
2. Double-click **Startup** → click **Show Files**.
3. In the opened folder (stored in the **SYSVOL** directory), paste the `ChangeTimeZone.bat` file.
4. Close the folder window.
5. Back in the **Startup Properties**, click:

   ```
   Add → Browse → Select ChangeTimeZone.bat → OK
   ```
6. Apply the changes with **OK → Apply**.

🗂️ **Note:** The SYSVOL folder automatically replicates across all domain controllers, ensuring the script is available to every domain-joined computer.

---

## 🔁 Step 5 — Apply and Verify the Policy

1. On a domain-joined client PC, open **Command Prompt** and run:

   ```
   gpupdate /force
   ```
2. Restart the computer (startup scripts only execute during system startup).
3. After reboot, verify the new time zone:

   * Open **Settings → Time & Language → Date & Time**
   * Confirm that the time zone matches the one defined in your script

---

## 🧩 Optional — Verify via Command Line

To confirm the applied time zone using Command Prompt:

```
tzutil /g
```

Example output:

```
Nepal Standard Time
```

---

## 🧱 Folder and GPO Path Summary

| Path Type          | Location                                                                   |
| ------------------ | -------------------------------------------------------------------------- |
| 🗂️ Script Storage | `\\<domain>\SYSVOL\<domain>\Policies\<GPO_GUID>\Machine\Scripts\Startup`   |
| 🧭 GPO Path        | `Computer Configuration → Policies → Windows Settings → Scripts (Startup)` |

---


## 🧠 Best Practices & Notes

* 🔒 Ensure the startup script runs **under system context**, which has privileges to change the time zone.
* 🧩 Apply the GPO to **Computers**, not **Users**.
* 🔄 Allow sufficient time for **GPO replication** across domain controllers.
* 🧰 Maintain a central repository of all custom startup scripts for version control.

---

## ✅ Summary

By deploying a startup script through Group Policy, administrators can:

| Benefit                  | Description                                    |
| ------------------------ | ---------------------------------------------- |
| 🕐 Unified Time Settings | Consistent time zone across all domain devices |
| 📅 Accurate Logging      | Event Viewer timestamps remain consistent      |
| ⚡ Simplified Management  | Centralized deployment using GPO               |
| 🧾 Auditable Changes     | Easy to verify via command or settings         |

---

 
