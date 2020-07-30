Configuration DscAdvCaptureServerConfig 
{
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"

    Node DscAdvCaptureServerConfig 
    {
        Service OnBaseAdvCapServer 
        {
            Name        = "OnBase AdvCap Server"
            StartupType = "Automatic"
            State       = "Running"
            Ensure      = "Present"
        }

        File AdvCapSched 
        {
            DestinationPath	= "C:\Program Files (x86)\Hyland\OnBase Client\OBAdvCapCLNT32.exe"
            SourcePath 		= "C:\Program Files (x86)\Hyland\OnBase Client\obclnt32.exe"
            Ensure 			= "Present"
            Type 			= "File"
        }

        File AdvCapSchedConfig 
        {
            DestinationPath	= "C:\Program Files (x86)\Hyland\OnBase Client\OBAdvCapCLNT32.exe.config"
            SourcePath 		= "C:\Program Files (x86)\Hyland\OnBase Client\obclnt32.exe.config"
            Ensure 			= "Present"
            Type 			= "File"
            DependsOn       = "[File]AdvCapSched"
        }
    }
} 