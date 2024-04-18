# Create a new trust rule.
Clear-Host
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
$ErrorActionPreference = 'Stop'

$Config     = (Get-Content "$PSScriptRoot\TM-Config.json" -Raw) | ConvertFrom-Json
$Manager    = $Config.MANAGER
$APIKEY     = $Config.APIKEY

$C1_URI     = "https://" + $Manager + "/api/applicationcontroltrustrules"

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", $APIKEY)
$headers.Add("api-version", 'v1')
$headers.Add("Content-Type", "application/json")

$TrustRule = @{
    "type" = "blockByTarget";
    "name" = "Block Trust Rule By Target";
    "description"  = "Trust Rule Description";
    "attributes" = @(
        @{
            "name" = "vendor";
            "value" = "Google LLC"
        };
        @{
            "name" = "productName";
            "value" = "Google Update"
        }
    )
}
$TrustRule_Payload =  $TrustRule | ConvertTo-Json -Depth 4

try {
    $TrustRule_Results =  Invoke-RestMethod -Uri $C1_URI -Method Post -Headers $Headers -Body $TrustRule_Payload
    Write-Host "[INFO]  Connection Successful"
}
catch {
    Write-Host "[ERROR]	$_"
    Exit
}

$TrustRule_Output = $TrustRule_Results | ConvertTo-Json -Depth 4

Write-Host $TrustRule_Output