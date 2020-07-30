Configuration DscIisServerConfig 
{
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xWebAdministration"

    Node DscIisServerConfig 
    {
		# Install IIS Role and components
        WindowsFeature IIS 
        {
            Ensure        	= "Present"
            Name          	= "Web-Server"
        }
        WindowsFeature Web-Static-Content 
        {
            Ensure        	= "Present"
            Name          	= "Web-Static-Content"
        }
        WindowsFeature Default-Doc 
        {
            Ensure        	= "Present"
            Name          	= "Web-Default-Doc"
        }
        WindowsFeature Asp-Net45 
        {
            Ensure        	= "Present"
            Name          	= "Web-Asp-Net45"
        }
        WindowsFeature Net-Ext45 
        {
            Ensure        	= "Present"
            Name          	= "Web-Net-Ext45"
        }
        WindowsFeature ISAPI-Ext 
        {
            Ensure        	= "Present"
            Name          	= "Web-ISAPI-Ext"
        }
        WindowsFeature ISAPI-Filter 
        {
            Ensure        	= "Present"
            Name          	= "Web-ISAPI-Filter"
        }
        WindowsFeature Filtering 
        {
            Ensure        	= "Present"
            Name          	= "Web-Filtering"
        }
        WindowsFeature Mgmt-Console 
        {
            Ensure        	= "Present"
            Name          	= "Web-Mgmt-Console"
        }
        WindowsFeature Windows-Auth 
        { 
            Ensure        	= "Present"
            Name          	= "Web-Windows-Auth"
        }
        
        # xWebAdministration Stuff
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