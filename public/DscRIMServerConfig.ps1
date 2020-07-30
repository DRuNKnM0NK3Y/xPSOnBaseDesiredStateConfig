Configuration DscRIMServerConfig 
{
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"

    Node DscRIMServerConfig     
    {
        Service OnBaseRIMServer 
        {
            Name        = "OnBase RIM Server"
            StartupType = "Automatic"
            State       = "Running"
            Ensure      = "Present"
        }

        File RIMServer 
        {
            DestinationPath	= "C:\Program Files (x86)\Hyland\OnBase Client\OBRIMCLNT32.exe"
            SourcePath 		= "C:\Program Files (x86)\Hyland\OnBase Client\obclnt32.exe"
            Ensure 			= "Present"
            Type 			= "File"
        }

        File RIMServerConfig 
        {
            DestinationPath	= "C:\Program Files (x86)\Hyland\OnBase Client\OBRIMCLNT32.exe.config"
            SourcePath 		= "C:\Program Files (x86)\Hyland\OnBase Client\obclnt32.exe.config"
            Ensure 			= "Present"
            Type 			= "File"
            DependsOn       = "[File]RIMServer"
        }
    }
} 