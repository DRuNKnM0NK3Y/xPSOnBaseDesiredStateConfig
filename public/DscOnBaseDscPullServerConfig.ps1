Configuration DscOnBaseDscPullServerConfig 
{
    param 
    (
        [Parameter()]
        [string[]]$EndpointName = "OnBaseDSC",
        
        [Parameter()]
		[ValidateNotNullOrEmpty()]
		[string] $certificateThumbPrint,
        
        [Parameter()]
		[ValidateNotNullOrEmpty()]
		[string] $RegistrationKey
	)
	
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
	Import-DSCResource -ModuleName "xPSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xWebAdministration"
	
	Node DscOnBaseDscPullServerConfig
	{
        WindowsFeature DSCServiceFeature 
        {
			Ensure = "Present"
			Name   = "DSC-Service"
		}

        xIisLogging Logging 
        {
            LogPath = "D:\inetpub\logs\LogFiles"
            LogLocalTimeRollover = $true
            LogPeriod = "Daily"
            LogFormat = "W3C"
        }

        File DSCModules 
        {
            Ensure = "Present"
            Type 			= "Directory"
            DestinationPath	= "D:\DscService\Modules"
        }

        File DSCConfiguration 
        {
            Ensure = "Present"
            Type 			= "Directory"
            DestinationPath	=  "D:\DscService\Configuration"
        }
		
        xDscWebService PSDSCPullServer 
        {
			Ensure                   = "Present"
			EndpointName             = $EndpointName
			Port                     = 8080
			PhysicalPath             = "D:\inetpub\wwwroot\OnBaseDSC"
			CertificateThumbPrint    = $certificateThumbPrint
			ModulePath               = "D:\DscService\Modules"
			ConfigurationPath        = "D:\DscService\Configuration"
			State                    = "Started"
			DependsOn                = "[WindowsFeature]DSCServiceFeature"
			UseSecurityBestPractices = $true
        }
		
        File RegistrationKeyFile 
        {
			Ensure          = "Present"
			Type            = "File"
			DestinationPath = "D:\DscService\RegistrationKeys.txt"
			Contents        = $RegistrationKey
		}
	}
} 