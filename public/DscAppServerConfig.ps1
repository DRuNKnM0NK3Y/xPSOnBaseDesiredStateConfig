Configuration DscAppServerConfig 
{
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xWebAdministration"

    Node DscAppServerConfig
    {
        xWebAppPool AppServer 
        {
            Name   					= "AppServer"
            Ensure 					= "Present"
            State  					= "Started"
			ManagedRuntimeVersion 	= "v4.0"
			managedPipelineMode		= "Integrated"
            IdentityType 			= "NetworkService"
        }

        xWebApplication AppServer 
        {
            Name 			= "AppServer"
            Website 		= "Default Web Site"
            WebAppPool 		= "AppServer"
            PhysicalPath 	= "D:\inetpub\wwwroot\AppServer"
			AuthenticationInfo  = `
				MSFT_xWebApplicationAuthenticationInformation
				{
				    Anonymous   = $false
                    Basic       = $false
				    Windows     = $true
				}
			SslFlags		 = "Ssl"
            EnabledProtocols = "https"
			Ensure 			 = "Present"
            DependsOn 		 = @("[xWebAppPool]AppServer")
        }
    }
} 