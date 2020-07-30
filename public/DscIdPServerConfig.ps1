Configuration DscIdPServerConfig 
{
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xWebAdministration"

    Node DscIdPServerConfig
    {
        # Install IIS Role and components
        WindowsFeature IIS 
        {
            Ensure        	= "Present"
            Name          	= "Web-Server"
        }
        
        WindowsFeature Mgmt-Console 
        {
            Ensure        	= "Present"
            Name          	= "Web-Mgmt-Console"
        }
        
        xWebsite DefaultSite 
        {
            Ensure          = "Present"
            Name            = "Default Web Site"
            State           = "Started"
            PhysicalPath    = "D:\inetpub\wwwroot"
            DependsOn       = "[WindowsFeature]IIS"
        }

        xIisLogging Logging 
        {
            LogPath = "D:\inetpub\logs\LogFiles"
            LogLocalTimeRollover = $true
            LogPeriod = "Daily"
            LogFormat = "W3C"
        }
    }
} 