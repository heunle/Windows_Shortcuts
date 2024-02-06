# Check for Administrator privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# If not running as Administrator, relaunch as Administrator
if (-not $isAdmin) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    Exit
}

# The rest of your script goes here

$networkAdapter = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }

$primaryDNS = "76.76.19.19"
$secondaryDNS = "76.223.122.150"

$dnsServers = @($primaryDNS, $secondaryDNS)

$networkAdapter.SetDNSServerSearchOrder($dnsServers)
