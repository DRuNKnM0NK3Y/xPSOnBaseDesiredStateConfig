Configuration DscDataCaptureServerConfig 
{
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"

    Node DscDataCaptureServerConfig
    {
        Service DataCaptureService 
        {
            Name = "Hyland.DataCapture.Server"
            StartupType = "Automatic"
            State = "Running"
            Ensure = "Present"
        }
    }
} 