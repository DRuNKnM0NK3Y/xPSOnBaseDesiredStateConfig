Configuration DscOnBaseFileServerConfig 
{
    param 
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$FullAccess,
        
        [Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$ChangeAccess
    )

    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xSmbShare"

    Node DscOnBaseFileServerConfig
    {
        File D_DiskGroups 
        {
            Ensure        	= "Present"
            Type 			= "Directory"
            DestinationPath	= "D:\Disk Groups"
        }

        xSmbShare D_DiskGroups 
        { 
            Ensure        	= "Present"
            Name 			= "DiskGroups_D$"
            Path 			= "D:\Disk Groups"
            FullAccess 		= $FullAccess
            ChangeAccess 	= $ChangeAccess
            DependsOn 		= "[File]D_DiskGroups"
        }

        File E_DiskGroups 
        {
            Ensure        	= "Present"
            Type 			= "Directory"
            DestinationPath	= "E:\Disk Groups"
        }

        xSmbShare E_DiskGroups 
        { 
            Ensure        	= "Present"
            Name 			= "DiskGroups_E$"
            Path 			= "E:\Disk Groups"
            FullAccess 		= $FullAccess
            ChangeAccess 	= $ChangeAccess
            DependsOn 		= "[File]E_DiskGroups"
        }
    }
}