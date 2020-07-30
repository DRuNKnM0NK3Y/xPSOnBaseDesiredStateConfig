[DSCLocalConfigurationManager()]
Configuration DscOnBaseFileSvrLCMConfig 
{
    param 
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [String]$NodeName = "Localhost",

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$ServerURL,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$RegistrationKey
    )
    
    Node $NodeName
    {
        Settings
        {
            RefreshMode = "Pull";
            RefreshFrequencyMins = 30;
            ConfigurationMode = "ApplyandAutoCorrect";
            ConfigurationModeFrequencyMins = 60;
            AllowModuleOverwrite = $true;
            RebootNodeIfNeeded = $false;
        }

        ConfigurationRepositoryWeb onbasedsc
        {
            ServerURL = $ServerURL
            RegistrationKey = $RegistrationKey
            ConfigurationNames = @("DscOnBaseFileServerConfig")
        }

        ReportServerWeb onbasedsc
        {
            ServerURL = $ServerURL
            RegistrationKey = $RegistrationKey
        }

        ResourceRepositoryWeb onbasedscResource
        {
            ServerURL = $ServerURL
        }
        
        PartialConfiguration DscOnBaseFileServerConfig {
            Description = "OnBaseFileServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }   
    }
}