Configuration DscOnBaseClientConfig 
{
    param 
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$OnBaseClientPID,
        
        [Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$OnBaseClientFilePath
    )
    
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"

    Node DscOnBaseClientConfig
    {
        xPackage OnBaseClient 
        {
            ProductID = $OnBaseClientPID
            Name = 'Hyland OnBase Client'
            Path = $OnBaseClientFilePath
            Ensure = 'Present'
            IgnoreReboot = $true
        }
    }
}