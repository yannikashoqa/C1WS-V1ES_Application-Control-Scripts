# C1WS-V1ES_Application-Control-Scripts

AUTHOR		: Yanni Kashoqa

TITLE		: Cloud One Workload Security / Vision One Endpoint Security Application Control Scripts

DESCRIPTION	: Various Powershell script to automate Application Control tasks.

FEATURES
- Supports for Cloud One Workload Security and Vision One Server and Workload Protection
- The ability to perform the following:-
    - List and Create Globel Rules
    - List and Describe Rulesets
    - List and Describe Ruleset Rule/s
    - List, Create and Describe Trust Rulesets
    - List, Create and Trust Rules
- Reference: https://cloudone.trendmicro.com/docs/workload-security/application-control-trust-entities/


REQUIRMENTS

- PowerShell 6.x Core or greater
- An API key that is created on the Cloud One console with Full permissions to Workload Security
- Create a TM-Config.json in the same folder with the following content:
~~~~JSON
{
    "MANAGER": "workload.us-1.cloudone.trendmicro.com",
    "APIKEY" : " ApiKey <Cloud One API Key>"
}
~~~~

