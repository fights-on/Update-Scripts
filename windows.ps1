function update {
    Write-Host "System Updater`n" -ForegroundColor "Cyan"
    Write-Host "[+] Checking for Administrator: " -NoNewline -ForegroundColor "Green"
    $CurrentPrincipal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())
    If ($CurrentPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "OK"
        Write-Host "[+] Checking for PSWindowsUpdate: " -NoNewline -ForegroundColor "Green"
        If (Get-Module -ListAvailable -Name PSWindowsUpdate) {
            Write-Host "OK"
            Write-Host "[+] Updating Windows: " -ForegroundColor "Green"
            Get-WindowsUpdate -Install -AcceptAll -AutoReboot
        } Else {
            Write-Host "`n[!] YOU MUST HAVE THE PSWindowsUpdate MODULE INSTALLED FOR WINDPWS UPDATE FEATURES!" -ForegroundColor "Red"
        }
        Write-Host "[+] Checking for Chocolatey: " -NoNewline -ForegroundColor "Green"
        If (!($(Get-Module -ListAvailable -Name "C:\ProgramData\chocolatey\helpers\chocolateyProfile.psm1").ExportedCommands.Count -eq 0)) {
            Write-Host "OK"
            Write-Host "[+] Updating Chocolatey: " -ForegroundColor "Green"
            choco upgrade all -y
        } Else {
            Write-Host "`n[!] YOU MUST HAVE Chocolatey INSTALLED FOR APPLICATION UPDATE FEATURE!" -ForegroundColor "Red"
        }
        Write-Host "`n[!] Would you like to reboot? [y/N] > " -NoNewline -ForegroundColor "Yellow"
        $Response = Read-Host
        Switch -Regex ($Response.ToLower()){
            '^(y)' {Restart-Computer}
        }
    } Else {
        Write-Host "`n[!] YOU MUST BE ADMIN!" -ForegroundColor "Red"
    }
}
