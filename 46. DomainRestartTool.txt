@echo off
setlocal enabledelayedexpansion
title Domain Remote Power Tool (Multi-Exclude Fix)

echo ===================================================
echo [STEP 1] ACTIVE DIRECTORY COMPUTER LIST
echo ===================================================
powershell -Command "Get-ADComputer -Filter * | Select-Object -ExpandProperty Name"
echo ---------------------------------------------------

echo ===================================================
echo [STEP 2] SET EXCLUSIONS
echo ===================================================
echo Type the name(s) to EXCLUDE. 
echo IMPORTANT: Separate names with a PIPE symbol only.
echo Example: SERVER^|DODO^|AGENT1
echo.
set /p "USER_EXCLUDE=Enter name(s) to skip: "

:: If empty, we use a dummy value that won't match anything
if "%USER_EXCLUDE%"=="" (set "FINAL_FILTER=NONE_SPECIFIED") else (set "FINAL_FILTER=%USER_EXCLUDE%")

echo.
echo ===================================================
echo [STEP 3] CHOOSE ACTION
echo ===================================================
:choice
set /P c=Type [R] to Restart, [S] to Shutdown, or [N] to Cancel: 
if /I "%c%" EQU "R" set "PS_CMD=Restart-Computer" & goto :EXECUTE
if /I "%c%" EQU "S" set "PS_CMD=Stop-Computer" & goto :EXECUTE
if /I "%c%" EQU "N" goto :END
goto :choice

:EXECUTE
echo.
echo ===================================================
echo [STEP 4] EXECUTION RESULTS
echo ===================================================

:: We use quotes around the filter to prevent the Batch crash
powershell -Command "$pcs = Get-ADComputer -Filter * | Where-Object { $_.Name -notmatch '%FINAL_FILTER%' } | Select-Object -ExpandProperty Name; foreach ($pc in $pcs) { Write-Host \"Attempting on $pc... \" -NoNewline; try { %PS_CMD% -ComputerName $pc -Force -ErrorAction Stop; Write-Host \"[SUCCESS]\" -ForegroundColor Green } catch { Write-Host \"[FAILED]\" -ForegroundColor Red } }"

echo ---------------------------------------------------
echo Operation Finished.
pause
goto :END

:END
exit