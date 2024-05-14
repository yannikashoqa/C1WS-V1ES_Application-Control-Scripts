Clear-Host
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$ErrorActionPreference = 'Stop'

$Config     = (Get-Content "$PSScriptRoot\TM-Config.json" -Raw) | ConvertFrom-Json
$Manager    = $Config.MANAGER
$APIKEY     = $Config.APIKEY

$SoftwareInventoryID = 1 # Use the Software_Inventories_List.ps1 to identify which List ID to use.

$C1_URI     = "https://" + $Manager + "/api/softwareinventories/" + $SoftwareInventoryID + "/items"

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $APIKEY)
$headers.Add("api-version", 'v1')
$headers.Add("Content-Type", "application/json")

try {
    $SoftwareInventoryRequest_Results =  Invoke-RestMethod -Uri $C1_URI -Method Get -Headers $Headers
    Write-Host "[INFO]  Connection Successful"
}
catch {
    Write-Host "[ERROR]	$_"
    Exit
}

$SoftwareInventoryRequest_Output = $SoftwareInventoryRequest_Results | ConvertTo-Json -Depth 4

Write-Host $SoftwareInventoryRequest_Output