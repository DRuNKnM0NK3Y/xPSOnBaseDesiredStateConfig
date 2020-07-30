Configuration DscOnBaseConfigurationConfig 
{
    param 
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$ConfigurationPID,
        
        [Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$ConfigurationFilePath
    )

    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"

    Node DscOnBaseConfigurationConfig
    {
        xPackage OnBaseClient 
        {
            ProductID = $ConfigurationPID
            Name = 'Hyland OnBase Configuration'
            Path = $ConfigurationFilePath
            Ensure = 'Present'
            IgnoreReboot = $true
        }
    }
}