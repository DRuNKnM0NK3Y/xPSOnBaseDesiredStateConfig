Configuration DscDiagnosticsConfig 
{
    param 
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$DiagnosticsPID,
        
        [Parameter()]
		[ValidateNotNullOrEmpty()]
		[string]$DiagnosticsFilePath
	)
    
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"
    Import-DscResource -ModuleName "xSmbShare"
    Import-DSCResource -ModuleName "xNetworking"
    
    Node DscDiagnosticsConfig
    {
        File OnBaseTemp 
        {
            Ensure        	= "Present"
            Type 			= "Directory"
            DestinationPath	= "D:\OnBaseTemp"
        }

        xEnvironment OnBaseTEMP 
        {
            Ensure          = "Present" 
            Name            = "OnBaseTEMP"
            Value           = "D:\OnBaseTemp"
        }

        xService RemoteMgt 
        {
            Name			= "WinRM"
        	StartUpType 	= "Automatic"
        }

        xPackage HylandDiagnostics 
        {
            ProductID = $DiagnosticsPID 
            Name = "Hyland Diagnostics Components"
            Path =  $DiagnosticsFilePath
            Ensure = 'Present'
            IgnoreReboot = $true
        }

        Service HylandDiagnostics 
        {
            Name			= "Hyland.Diagnostics.NTService"
            StartUpType 	= "Manual"
            DependsOn       = "[xPackage]HylandDiagnostics"
        }

        xFirewall DiagnosticsFW 
        {
			DisplayName 	= "Hyland Diagnostics"
            Name            = "Hyland Diagnostics"
        	Ensure			= "Present"
            Enabled			= "True"
			Profile			= "Domain"
			Direction		= "Inbound"
			Action			= "Allow"
			LocalPort       = "8989"
            Protocol		= "TCP"
            Program         = "C:\Program Files (x86)\Hyland\Services\Diagnostics\Hyland.Diagnostics.NTService.exe"
        }
    }
} 