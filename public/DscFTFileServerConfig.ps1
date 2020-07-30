Configuration DscFTFileServerConfig 
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

    Node DscFTFileServerConfig
    {
        File D_FullTextCatalog 
        {
            Ensure        	= "Present"
            Type 			= "Directory"
            DestinationPath	= "D:\Full-Text Catalog"
        }

        xSmbShare D_FullTextCatalog 
        { 
            Ensure        	= "Present"
            Name 			= "FullTextCatalog_D$"
            Path 			= "D:\Full-Text Catalog"
            FullAccess 		= $FullAccess
            ChangeAccess 	= $ChangeAccess
            DependsOn 		= "[File]D_FullTextCatalog"
        }
    }
} 