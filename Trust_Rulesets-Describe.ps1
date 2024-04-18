Clear-Host
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$ErrorActionPreference = 'Stop'

$Config     = (Get-Content "$PSScriptRoot\TM-Config.json" -Raw) | ConvertFrom-Json
$Manager    = $Config.MANAGER
$APIKEY     = $Config.APIKEY

$acTrustRulesetID = 67

$C1_URI     = "https://" + $Manager + "/api/applicationcontroltrustrulesets" + "/" + $acTrustRulesetID

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $APIKEY)
$headers.Add("api-version", 'v1')

try {
    $Rulesets_List_Results =  Invoke-RestMethod -Uri $C1_URI -Method Get -Headers $Headers
    Write-Host "[INFO]  Connection Successful"
}
catch {
    Write-Host "[ERROR]	$_"
    Exit
}

$Rulesets_List_Output = $Rulesets_List_Results | ConvertTo-Json -Depth 4

Write-Host $Rulesets_List_Output