Clear-Host
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$ErrorActionPreference = 'Stop'

$Config     = (Get-Content "$PSScriptRoot\TM-Config.json" -Raw) | ConvertFrom-Json
$Manager    = $Config.MANAGER
$APIKEY     = $Config.APIKEY

$acTrustRuleID = 68

$C1_URI     = "https://" + $Manager + "/api/applicationcontroltrustrules" + "/" + $acTrustRuleID

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $APIKEY)
$headers.Add("api-version", 'v1')
$headers.Add("Content-Type", "application/json")

$TrustRule = @{
    "name" = "Google Update";
    "description"  = ""
}
$TrustRule_Payload =  $TrustRule | ConvertTo-Json -Depth 4

try {
    $Trust_Rule_Results =  Invoke-RestMethod -Uri $C1_URI -Method Post -Headers $Headers -Body $TrustRule_Payload 
    Write-Host "[INFO]  Connection Successful"
}
catch {
    Write-Host "[ERROR]	$_"
    Exit
}

$Trust_Rule_Output = $Trust_Rule_Results | ConvertTo-Json -Depth 4

Write-Host $Trust_Rule_Output
