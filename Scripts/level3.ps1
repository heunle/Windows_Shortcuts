# Check for Administrator privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# If not running as Administrator, relaunch as Administrator
if (-not $isAdmin) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    Exit
}

# The rest of your script goes here

$networkAdapter = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }

$primaryDNS = "209.244.0.3"
$secondaryDNS = "209.244.0.4"

$dnsServers = @($primaryDNS, $secondaryDNS)

$networkAdapter.SetDNSServerSearchOrder($dnsServers)
