[DSCLocalConfigurationManager()]
Configuration DscWebServerLCMConfig 
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
            ConfigurationNames = @("DscDiagnosticsConfig","DscWebServerConfig")
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
        
        PartialConfiguration DscWebServerConfig {
            Description = "WebServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }   
    }
}