Function Update-PIP {
    Write-Host "PIP Updater" -ForegroundColor "Cyan"
    Write-Host "`n[+] Checking for Administrator: " -NoNewline -ForegroundColor "Green"
    $CurrentPrincipal = New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())
    If ($CurrentPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "OK"
        Write-Host "[+] Downloading/Running Get-PIP.py: " -ForegroundColor "Green"
        Invoke-WebRequest -Uri "https://raw.githubusercontent.com/pypa/get-pip/master/get-pip.py" -OutFile "$($env:Temp)\get-pip.py"
        python.exe "$($env:Temp)\get-pip.py"
        Write-Host "[+] Checking for PIP: " -NoNewline -ForegroundColor "Green"
        If (Get-Command "pip.exe" -ErrorAction SilentlyContinue){
            Write-Host "OK"
            Write-Host "[+] Updating Python Packages: " -ForegroundColor "Green"
            pip.exe list | Select-Object -Skip 2 | %{ $_.Split()[0]; } | %{pip.exe install --upgrade $_}
            Write-Host "[+] Done" -ForegroundColor "Green"
        } Else {
            Write-Host "`n[!] YOU MUST HAVE PIP INSTALLED!" -ForegroundColor "Red"
        }
    } Else {
        Write-Host "`n[!] YOU MUST BE ADMIN!" -ForegroundColor "Red"
    }
}
