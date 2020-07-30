Configuration DscUnitySchedulerConfig 
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
    }
} 