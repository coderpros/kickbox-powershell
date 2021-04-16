class KickBox 
{
    [string] $apiKey;

    KickBox([string] $ApiKey)
    {
        $this.apiKey = $ApiKey;
    }

    [object] verifySingleEmail([string] $emailAddress) 
    {
        $inputData = @{"email" = $emailAddress};

        return $this.callApi('verify', 'GET', $inputData) | ConvertFrom-Json;
    }

    [object] verifyBulkEmail([string[]] $emailAddresses) {
        return this.callApi('verify-batch', 'PUT') | ConvertFrom-Json;
    }

    [object] checkVerificationStatus([string] $jobId) {
        return this.callApi("verify-batch/$jobId", 'GET') | ConvertFrom-Json;
    }

    # Private Helpers
    hidden [object] callApi([string]$apiMethod, [string] $httpMethod, $inputData) {
        $contentType = 'application/octet-stream';
        $queryString = '';

        if($httpMethod -eq 'PUT'){
            $contentType = 'text/csv';
        }

        $headers = @{ 'Content-Type' = $contentType }

        foreach($key in $inputData.Keys) {
            $queryString = $queryString + "&" + $key + "=" + $inputData[$key]
        }

        $queryString = $queryString + "&apikey=" + $this.apiKey;
    
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        return Invoke-WebRequest -Uri "https://api.kickbox.com/v2/$apiMethod\?$queryString" -Method $httpMethod -Headers $headers; # -Body $this.inputData;
    }  
}

$kickboxObject = New-Object KickBox('live_740aa12661f1a3edb6a27e0ce6fc053d5ba218e92ce7bb21c389f8e848c2c5fa');

$singleVerificationResponse = $kickboxObject.verifySingleEmail('brandon.osborne@coderpro.net');

Write-Output('test')