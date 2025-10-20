. (Join-Path $PSScriptRoot 'Event-Logs.ps1')

clear

$loginoutsTable = Get-LogonLogoffEvents -Days 15
$loginoutsTable

$shutdownsTable = Get-StartupShutdownEvents -Days 25 | Where-Object {$_.Event -eq "Shutdown"}
$shutdownsTable

$startupsTable = Get-StartupShutdownEvents -Days 25 | Where-Object {$_.Event -eq "Startup"}
$startupsTable
