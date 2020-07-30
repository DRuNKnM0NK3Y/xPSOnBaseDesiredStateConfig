Configuration DscWebServerConfig 
{
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xSmbShare"
    Import-DscResource -ModuleName "xWebAdministration"

    Node DscWebServerConfig 
    {        
        xWebAppPool AppNet 
        {
            Name   					= "AppNet"
            Ensure 					= "Present"
            State  					= "Started"
            ManagedRuntimeVersion 	= "v4.0"
            managedPipelineMode     = "Integrated"
            IdentityType 			= "NetworkService"
        }
        
        xWebApplication AppNet 
        {
            Name 			= "AppNet"
            Website 		= "Default Web Site"
            WebAppPool 		= "AppNet"
            PhysicalPath 	= "D:\inetpub\wwwroot\AppNet"
            AuthenticationInfo  = `
                MSFT_xWebApplicationAuthenticationInformation
                {
                    Anonymous   = $true
                    Basic       = $false
                    Windows     = $false
                }
            SslFlags		    = "Ssl"
            EnabledProtocols    = "https"
            Ensure 			    = "Present"
            DependsOn 		    = @("[xWebAppPool]AppNet")
        }

        File StyleSheet 
        {
            Ensure        	= "Present"
            Type 			= "Directory"
            DestinationPath	= "D:\OnBaseWebProject\StyleSheet"
        }
        
        File Resource 
        {
            Ensure        	= "Present"
            Type 			= "Directory"
            DestinationPath	= "D:\OnBaseWebProject\Resource"
        }

        File ResourceBackup 
        {
            Ensure        	= "Present"
            Type 			= "Directory"
            DestinationPath	= "D:\OnBaseWebProject\Resource Backup"
        }

        xSmbShare OnBaseWebProject 
        { 
            Ensure        	= "Present"
            Name 			= "OnBaseWebProject"
            Path 			= "D:\OnBaseWebProject"
            FullAccess 		= "Administrators"
            ChangeAccess 	= "Users"
        }
    }
} 