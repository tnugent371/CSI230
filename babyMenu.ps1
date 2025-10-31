. "$PSScriptRoot\ApacheLogs1.ps1"
. "$PSScriptRoot\Event-Logs.ps1"

function showApacheLogs {
    $logs = ApacheLogs1 | Select-Object -last 10
    if ($logs) {
        Write-Host "`nlast 10 Apache Logs`n"
        $logs | Format-Table -AutoSize -Wrap
    } else {
        Write-Host "No matching logs found."
    }
}

function showFailedLogins {
    $failed = getFailedLogins(7) | Select-Object -Last 10
    if ($failed) {
        Write-Host "`nLast 10 Failed Logins:`n"
        $failed | Format-Table -AutoSize
    } else {Write-Host "No failed logins found."}
}

function showAtRisk {
    $days = Read-Host -Prompt "Enter how many days to check for at-risk users"
    if (-not ($days -match '^\d+$')) {
        Write-Host "Invalid input."
        return
    }

    $failedLogins = getFailedLogins($days)
    $grouped = $failedLogins | Group-Object -Property User | Where-Object {$_.Count -gt 10}

    if($grouped.Count -eq 0) {
        Write-Host "No at risk users found in the last $days days."
        foreach($g in $grouped) {
            Write-Host ("User: {0}, Failed logins: {1}" -f $g.Name, $g.Count)
        }
    }
}

function toggleChrome {
    $chrome = Get-Process -Name "chrome" -ErrorAction SilentlyContinue
    if(-not $chrome) {
        Write-Host "Starting Chrome..."
        Start-Process "chrome.exe" "https://www.champlain.edu"
    } else {
        Write-Host "Stopping Chrome..."
        Stop-Process -Name "chrome"
    }
}

do {
    Write-Host "Baby's First Menu"
    Write-Host "1. Display last 10 Apache logs"
    Write-Host "2. Display last 10 failed logins"
    Write-Host "3. Display at risk users"
    Write-Host "4. Toggle Chrome"
    Write-Host "5. Exit"

    $choice = Read-Host "Enter your choice"

    if($choice -eq "1"){
        showApacheLogs
    } elseif($choice -eq "2") {
        showFailedLogins
    } elseif($choice -eq "3") {
        showAtRisk
    } elseif($choice -eq "4") {
        toggleChrome
    }
  
} until ($choice -eq "5")