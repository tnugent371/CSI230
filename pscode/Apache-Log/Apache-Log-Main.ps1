. .\Apache-Logs.ps1

$ips = Get-ApacheLogs -page "index.html" -code "200" -browser "Chrome"
$ips | Group-Object IP | Select-Object Count, Name
