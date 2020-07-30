[DSCLocalConfigurationManager()]
Configuration DscSandboxSvrLCMConfig 
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
            ConfigurationModeFrequencyMins = 15;
            AllowModuleOverwrite = $true;
            RebootNodeIfNeeded = $false;
        }

        ConfigurationRepositoryWeb onbasedsc
        {
            ServerURL = $ServerURL
            RegistrationKey = $RegistrationKey
            ConfigurationNames = @("DscDiagnosticsConfig"
            ,"DscIisServerConfig"
            ,"DscAppServerConfig"
            ,"DscWebServerConfig"
            ,"DscDataCaptureServerConfig"
            ,"DscFullTextServerConfig"
            ,"DscFTFileServerConfig"
            ,"DscUnitySchedulerConfig"
            ,"DscOnBaseClientConfig"
            ,"DscOnBaseConfigurationConfig"
            ,"DscMailBoxImporterSvcConfig"
            ,"DscAdvCaptureServerConfig"
            ,"DscRIMServerConfig"
            ,"DscOnBaseFileServerConfig"
            )
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
                
        PartialConfiguration DscDiagnosticsConfig 
        {
            Description = "Diagnostics"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }
        
        PartialConfiguration DscIisServerConfig 
        {
            Description = "IisServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscAppServerConfig 
        {
            Description = "AppServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscWebServerConfig 
        {
            Description = "WebServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscDataCaptureServerConfig 
        {
            Description = "DataCaptureServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscFullTextServerConfig 
        {
            Description = "FullTextServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscFTFileServerConfig 
        {
            Description = "FTFileServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscUnitySchedulerConfig 
        {
            Description = "UnityScheduler"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscOnBaseClientConfig
        {
            Description = "OnBase Client"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }
        
        PartialConfiguration DscOnBaseConfigurationConfig
        {
            Description = "OnBase Config"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscMailBoxImporterSvcConfig 
        {
            Description = "MailBoxImporterSvc"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscAdvCaptureServerConfig 
        {
            Description = "AdvCaptureServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscRIMServerConfig
        {
            Description = "RIMServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }

        PartialConfiguration DscOnBaseFileServerConfig 
        {
            Description = "OnBaseFileServer"
            ConfigurationSource = @("[ConfigurationRepositoryWeb]onbasedsc")
        }
    }
}