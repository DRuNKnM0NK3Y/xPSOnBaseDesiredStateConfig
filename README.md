---
## **Introduction**
The purpose of this project is to provide a Powershell Desired State Configuration mechanism to manage an OnBase Environment and ensure consistency across environments.

The configurations are built on an *a la carte* model.  Each service has its own config file, allowing individual nodes to be configured with the desired services.

---
## **Requirements**
This module requires the following DSC resources available on Powershell Gallery
- **PSDesiredStateConfiguration**
- **xPSDesiredStateConfiguration**
- **xNetworking**
- **xSmbShare** (DEPRECATED) This module has been replaced with *ComputerManagementDSC* module, but I've not yet transitioned to this new module.
- **xWebAdministration**

---
## **Installation**

Download and extract the Powershell Module.
From the extracted folder, run:

```
Import-Module -Name .\xPSOnBaseDesiredStateConfig.psm1
```
*need to troubleshoot the ps1 loading script in the abovev psm1*

This will make the Configurations runnable for the current PowerShell session.  If you close the ISE or Powershell command window, you will have to re-import the module.

To make the module perpetually available, copy it to a folder included in the `$env:PSModulePath`

---
## **Resources**
### **Functional Server Configurations**
Contains functional role configuration (Web server, App Server, Data Capture Server, etc.)
- **DscDiagnosticsConfig**
- **DscIisServerConfig**
- **DscAppServerConfig**
- **DscWebServerConfig**
- **DscDataCaptureServerConfig**
- **DscFullTextServerConfig**
- **DscFTFileServerConfig**
- **DscUnitySchedulerConfig**
- **DscMailBoxImporterSvcConfig**
- **DscAdvCaptureServerConfig**
- **DscRIMServerConfig**
- **DscOnBaseFileServerConfig**
- **DscIdPServerConfig**
- **OnBaseClientConfig**
- **OnBaseConfigurationConfig**
- **DscOnBaseDscPullServerConfig**


Create the MOF files for each configuration:
```
DscAppServerConfig -OutputPath: ".\DSCMof"
```

Then create the checksum:

```
New-DscChecksum -Path ".\DSCMof"
```

Each MOF file and its checksum are stored in the *Configurations* directory of the DSC Pull Server.

Also included is a `Get-ProductID` helper function to grab the Product ID's required for *xPSDesiredStateConfiguration* to automatically install software.  Currently it just pulls all the installed software and product id's, but the future intent is to parameterize so as to pull just the PIDs desired.

---
### **DSC Local Configuration Manager Settings**

Creates LCM Meta Configuration MOF for the target node to point to DSC Pull Server and pull corresponding configurations.

- **DscAppServerLCMConfig**
- **DscWebServerLCMConfig**
- **DscDataCaptureServerLCMConfig**
- **DscFullTextServerLCMConfig**
- **DscFTFileServerLCMConfig**
- **DscUnityServerLCMConfig**
- **DscOnBaseFileSvrLCMConfig**
- **DscIdpServerLCMConfig**
- **DscSandboxSvrLCMConfig**
- **DscOnBaseDscPullSvrLCMConfig**

Create LCM Meta Configuration MOF:
```
PullSandboxSvr -NodeName *Server01*
```
Apply the Meta Configuration MOF to Target Node:
```
$Session = New-CimSession -ComputerName "Server01" -Credential Domain\Username
Set-DscLocalConfigurationManager -path .\PullSandboxSvr -CimSession $Session
```
---
### **To Do**
- [x] Parameterize configs.
- [ ] Replace Deprecated xSmbShare resource from *xPSDesiredStateConfiguration* with *ComputerManagementDSC*.
- [ ] Fix ps1 loader function in *xPSOnBaseDesiredStateConfig.psm1*.
- [ ] Configure DSC configs to automatically install software.
-   [x] Diagnostics Services
-   [x] OnBase Configuration
-   [ ] OnBase Client
-   [ ] OnBase AppServer
-   [ ] OnBase WebServer
-   [ ] Data Capture Server
-   [ ] Full-Text Server
-   [ ] Unity Scheduler
-   [ ] Mailbox Importer
