# Assign additional trust rule IDs to a trust ruleset.
Clear-Host
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$ErrorActionPreference = 'Stop'

$Config     = (Get-Content "$PSScriptRoot\TM-Config.json" -Raw) | ConvertFrom-Json
$Manager    = $Config.MANAGER
$APIKEY     = $Config.APIKEY

$acTrustRulesetID = 67
$C1_URI     = "https://" + $Manager + "/api/applicationcontroltrustrulesets/" + $acTrustRulesetID + "/rules"

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $APIKEY)
$headers.Add("api-version", 'v1')
$headers.Add("Content-Type", "application/json")

$TrustRules = @{
    "ruleIDs" = @(
        68
    )
}
$TrustRules_Payload =  $TrustRules | ConvertTo-Json -Depth 4

try {
    $TrustRulesets_Results =  Invoke-RestMethod -Uri $C1_URI -Method Post -Headers $Headers -Body $TrustRules_Payload
    Write-Host "[INFO]  Connection Successful"
}
catch {
    Write-Host "[ERROR]	$_"
    Exit
}

$TrustRulesets_Output = $TrustRulesets_Results | ConvertTo-Json -Depth 4

Write-Host $TrustRulesets_Output