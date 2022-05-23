. "${global:AestheticConsoleModuleRoot}\Private\Format-Directory.ps1"
. "${global:AestheticConsoleModuleRoot}\Private\Format-File.ps1"
. "${global:AestheticConsoleModuleRoot}\Private\Format-Link.ps1"
Function Format-AestheticConsole {
    Param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $fObj
    )
    if ($fObj.LinkType -eq "Junction" -or $fObj.LinkType -eq "SymbolicLink") {
        Format-Link -Link $fObj
    }
    elseif ($fObj -is [System.IO.DirectoryInfo]) {
        Format-Directory -Directory $fObj
    }
    else {
        Format-File -File $fObj
    }
}