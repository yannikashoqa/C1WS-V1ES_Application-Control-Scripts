# Create a new trust ruleset.
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
$headers.Add("Content-Type", "application/json")


$TrustRuleSet = @{
    "name" = "API Test";
    "description"  = "Trust Ruleset Description"
}

$TrustRuleSet_Payload =  $TrustRuleSet | ConvertTo-Json -Depth 4

try {
    $TrustRulesets_Output =  Invoke-RestMethod -Uri $C1_URI -Method Post -Headers $Headers -Body $TrustRuleSet_Payload 
    Write-Host "[INFO]  Connection Successful"
}
catch {
    Write-Host "[ERROR]	$_"
    Exit
}

$TrustRulesets_Output = $TrustRulesets_Output | ConvertTo-Json -Depth 4

Write-Host $TrustRulesets_Output