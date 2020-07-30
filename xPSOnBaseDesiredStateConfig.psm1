Write-Verbose "Importing Functions"

# Import everything in these folders
foreach($folder in @('private','public','classes'))
{
    $root = Join-Path $PSScriptRoot -ChildPath $folder
    if(Test-Path -Path $root)
    {
        Write-Verbose "processing folder $root"
        $files = Get-ChildItem -path $root -FIlter *.ps1

        # dot source each file
        $files | Where-Object{$_.name -NotLike '*Tests.ps1'} |
            ForEach-Object{Write-Verbose $_.name; . $_.FullName}
    }
}

Export-ModuleMember -Function (Get-ChildItem -Path "$PSScriptRoot\public\*.ps1")