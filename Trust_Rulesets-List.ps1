Clear-Host
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$ErrorActionPreference = 'Stop'

$Config     = (Get-Content "$PSScriptRoot\TM-Config.json" -Raw) | ConvertFrom-Json
$Manager    = $Config.MANAGER
$APIKEY     = $Config.APIKEY

$C1_URI     = "https://" + $Manager + "/api/applicationcontroltrustrulesets"

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $APIKEY)
$headers.Add("api-version", 'v1')

try {
    $Rulesets_List =  Invoke-RestMethod -Uri $C1_URI -Method Get -Headers $Headers
    Write-Host "[INFO]  Connection Successful"
}
catch {
    Write-Host "[ERROR]	$_"
    Exit
}

$Rulesets_List = $Rulesets_List | ConvertTo-Json -Depth 4

Write-Host $Rulesets_List