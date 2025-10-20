function Get-LogonLogoffEvents {
    param([int]$Days = 14)
    $loginouts = Get-EventLog System -Source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-$Days)

    $loginoutsTable = @()

    for($i=0; $i -lt $loginouts.Count; $i++) {

        $event = ""

        if($loginouts[$i].InstanceId -eq 7001) {$event = "Logon"}
        if($loginouts[$i].InstanceId -eq 7002) {$event = "Logoff"}

        $sid = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
        $user = $sid.Translate([System.Security.Principal.NTAccount]).Value

        $loginoutsTable += [PSCustomObject]@{
            "Time" = $loginouts[$i].TimeGenerated
            "Id" = $loginouts[$i].instanceId
            "Event" = $event
            "User" = $user
        }
    }
    return $loginoutsTable
}

function Get-StartupShutdownEvents {
    param([int]$Days = 14)

    $startstops = Get-EventLog System -After (Get-Date).AddDays(-$Days) | Where-Object {$_.EventId -in 6005, 6006}

    $startstopsTable = @()

    for($i=0; $i -lt $startstops.Count; $i++) {
        $event = ""

        if($startstops[$i].EventId -eq 6005) {$event = "Startup"} else {$event = "Shutdown"}
    
        $startstopsTable += [PSCustomObject]@{
            "Time" = $startstops[$i].TimeGenerated
            "Id" = $startstops[$i].EventId
            "Event" = $event
            "User" = "System"
        }
    }
    return $startstopsTable
}
