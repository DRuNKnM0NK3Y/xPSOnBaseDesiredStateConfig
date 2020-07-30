[DSCLocalConfigurationManager()]
Configuration DscFullTextServerLCMConfig 
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
            #ConfigurationID = "fc0b764b-0263-4c0f-afa3-c9c69b243781";
            AllowModuleOverwrite = $true;
            RebootNodeIfNeeded = $false;
        }

        ConfigurationRepositoryWeb onbasedsc
        {
            ServerURL = $ServerURL
            RegistrationKey = $RegistrationKey
            ConfigurationNames = @("DscDiagnosticsConfig","DscFullTextServerConfig")
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
                
        PartialConfiguration DscDiagnosticsConfig {
            Description = "Diagnostics"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }
        
        PartialConfiguration DscFullTextServerConfig {
            Description = "FullTextServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }    
    }
}