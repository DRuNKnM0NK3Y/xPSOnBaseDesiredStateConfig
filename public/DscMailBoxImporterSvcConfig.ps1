Configuration DscMailBoxImporterSvcConfig 
{
    Import-DscResource -ModuleName "PSDesiredStateConfiguration" -ModuleVersion 1.1
    Import-DscResource -ModuleName "xPSDesiredStateConfiguration"

    Node DscMailBoxImporterSvcConfig
    {
        Service MailBoxImporterSvc 
        {
            Name = "Hyland Mailbox Importer Service"
            StartupType = "Automatic"
            State = "Running"
            Ensure = "Present"
        }
    }
} 