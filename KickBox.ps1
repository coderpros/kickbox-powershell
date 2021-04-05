class KickBox 
{
    [string] $ApiKey;

    KickBox([string] $ApiKey)
    {
        this.ApiKey = $ApiKey;
    }

    static verifySingleEmail([string]$emailAddress) 
    {

    }

    static verifyBulkEmail($emailAddresses)
    {

    }

    static checkVerificationStatus([string]$jobId)
    {

    }

    # Private Helpers
    hidden callApi([string]$url, [string]$apiMethod, [string]$httpMethod, $postData)
    {
        $username = '5KL1URBK68NINU41LAQR2B8OH89T2FCF2EQQDRT86ZQYFXOBN18XPZ0QLV18B31O32EP81DC7I880TEC13RVOOW0MD2IAMUII87V9AB495CJ4Y1OTANU28MXOWTW2E9G';
        $password = 'L8NK0X2A50I2J15GPP51GWEZQ7I094II8NOGZI6SBDQI09GPEWXJUSA8DUIZTAVUXKDP1AG5MBTD0EH9BUEVKQVRPE3Z95F2HT79AY975F7ZKZQV22T1S2XZPTHSY644';
        $credPair = "$($username):$($password)"
    
        $encodedCredentials = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($credPair))
           
        $headers = @{ Authorization = "Basic $encodedCredentials" }
    
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $responseData = Invoke-WebRequest -Uri "$url/$apiMethod" -Method $httpMethod -Headers $headers -UseBasicParsing -Body $postData
    }  
}