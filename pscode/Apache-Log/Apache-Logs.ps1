function Get-ApacheLogs {
    param(
            [string]$page,
            [string]$code,
            [string]$browser
    )
        
    $logs = Get-Content C:\xampp\apache\logs\access.log |
    Where-Object {$_ -match $page -and $_ -match $code -and $_ -match $browser}

    $regex = [regex]'\b\d{1,3}(\.\d{1,3}){3}\b'

    $ips = @()
    foreach ($line in $logs) {
        if ($line -match $regex) {
            $ips += [pscustomobject]@{"IP"=$Matches[0]}
        }
    }

    return $ips
}

