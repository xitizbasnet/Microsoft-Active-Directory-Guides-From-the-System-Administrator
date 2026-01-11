<# :
@echo off
title AD User Activity Report V2
powershell /nop /ex bypass /command "Get-Content '%~f0' | Out-String | iex"
pause
exit /b
#>

Import-Module ActiveDirectory

# Define paths
$PathAll = "$env:USERPROFILE\Desktop\User_Status_Report.csv"
$PathRecent = "$env:USERPROFILE\Desktop\Recent_Logins_30_Days.csv"

Write-Host "--- Starting Improved AD Audit ---" -ForegroundColor Yellow

# 1. Get ALL users with specific properties
$DateLimit = (Get-Date).AddDays(-30)
$RawUsers = Get-ADUser -Filter * -Properties LastLogonDate, Enabled

# 2. Process Data for Report 1 (Status: Enabled vs Disabled)
$StatusReport = $RawUsers | Select-Object Name, SamAccountName, 
    @{Name="AccountStatus"; Expression={if($_.Enabled){"Enabled (Active)"}else{"Disabled (Inactive)"}}}, 
    @{Name="LastLogin"; Expression={if($_.LastLogonDate){$_.LastLogonDate}else{"Never"}}}

# 3. Process Data for Report 2 (Truly logged in last 30 days)
# We filter for: Must be Enabled AND LastLogonDate must be within 30 days
$RecentReport = $RawUsers | Where-Object { $_.Enabled -eq $true -and $_.LastLogonDate -ne $null -and $_.LastLogonDate -gt $DateLimit } | 
    Select-Object Name, SamAccountName, LastLogonDate

# 4. Export to CSV using UTF8 and NoTypeInformation
$StatusReport | Export-Csv $PathAll -NoTypeInformation -Encoding UTF8 -Delimiter ','
$RecentReport | Export-Csv $PathRecent -NoTypeInformation -Encoding UTF8 -Delimiter ','

Write-Host "Success! Check your desktop for two CSV files." -ForegroundColor Green
