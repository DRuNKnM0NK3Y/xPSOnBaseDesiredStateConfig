Configuration DscCompositeUnitySchedulerConfig
{

    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xSmbShare"

    Node DscUnitySchedulerConfig
    {
        Service HylandUnityScheduler 
        {
            Name        = "Hyland Unity Scheduler_UnityScheduler"
            StartupType = "Automatic"
            State       = "Running"
            Ensure      = "Present"
        }

        # Distribution Svcs Temporary File Cache
        File TempFileCache 
        {
            Ensure        	= "Present"
            Type 			= "Directory"
            DestinationPath	= "D:\TempFileCache"
        }

        xSmbShare TempFileCache 
        { 
            Ensure        	= "Present"
            Name 			= "TempFileCache$"
            Path 			= "D:\TempFileCache"
            FullAccess 		= "Administrators"
            ChangeAccess 	= "Users"
            DependsOn 		= "[File]TempFileCache"
        }

        Service MailBoxImporterSvc 
        {
            Name = "Hyland Mailbox Importer Service"
            StartupType = "Automatic"
            State = "Running"
            Ensure = "Present"
        }

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
