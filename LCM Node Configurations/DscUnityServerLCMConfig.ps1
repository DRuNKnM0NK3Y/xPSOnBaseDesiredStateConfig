[DSCLocalConfigurationManager()]
Configuration DscUnityServerLCMConfig 
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
            ConfigurationNames = @("DscDiagnosticsConfig","DscUnitySchedulerConfig","DscMailBoxImporterSvcConfig","DscAdvCaptureServerConfig","DscRIMServerConfig")
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
        
        PartialConfiguration DscUnitySchedulerConfig {
            Description = "UnityScheduler"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }
        
        PartialConfiguration DscMailBoxImporterSvcConfig {
            Description = "MailboxImporterSvc"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscAdvCaptureServerConfig {
            Description = "AdvCaptureServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscRIMServerConfig {
            Description = "RIMServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }
    }
}