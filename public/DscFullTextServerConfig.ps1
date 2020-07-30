Configuration DscFullTextServerConfig 
{
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"
    Import-DSCResource -ModuleName "xNetworking"

    Node DscFullTextServerConfig
    {
        Service FTSvr 
        {
            Name        = "Hyland.FullText.Server"
            StartupType = "Automatic"
            State       = "Running"
            Ensure      = "Present"
        }

        xFirewall FTfw 
        {
			DisplayName 	= "Hyland Full-Text Search"
            Name            = "Hyland Full-Text Search"
        	Ensure			= "Present"
            Enabled			= "True"
			Profile			= "Domain"
			Direction		= "Inbound"
			Action			= "Allow"
			LocalPort       = ("4444")
            Protocol		= "TCP"
        }
    }
} 