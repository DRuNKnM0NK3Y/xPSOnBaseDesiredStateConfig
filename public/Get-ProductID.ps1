function Get-OnBaseProductID {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$OutFile
    )
    Get-WmiObject Win32_Product | Format-Table IdentifyingNumber, Name, LocalPackage | Out-File $OutFile
}