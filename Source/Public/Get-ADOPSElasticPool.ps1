function Get-ADOPSElasticPool {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Organization,

        [Parameter()]
        [int32]$PoolId

    )

    if (-not [string]::IsNullOrEmpty($Organization)) {
        $Org = GetADOPSHeader -Organization $Organization
    } else {
        $Org = GetADOPSHeader
        $Organization = $Org['Organization']
    }

    if ($PSBoundParameters.ContainsKey('PoolId')) {
        $Uri = "https://dev.azure.com/$Organization/_apis/distributedtask/elasticpools/$PoolId?api-version=7.1-preview.1"
    } else {
        $Uri = "https://dev.azure.com/$Organization/_apis/distributedtask/elasticpools?api-version=7.1-preview.1"
    }
    
    $Method = 'GET'
    $ElasticPoolInfo = InvokeADOPSRestMethod -Uri $Uri -Method $Method -Organization $Organization -Body $Body
    if ($ElasticPoolInfo.psobject.properties.name -contains 'value') {
        Write-Output $ElasticPoolInfo.value
    } else {
        Write-Output $ElasticPoolInfo
    }
}