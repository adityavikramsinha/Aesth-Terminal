. "${global:AestheticConsoleModuleRoot}\Private\Resolve-DirectoryColor.ps1"
. "${global:AestheticConsoleModuleRoot}\Private\Resolve-DirectoryIcon.ps1"

Function Format-Directory {
    Param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $Directory
    )
    process {
        [string]$ANSI = ( Resolve-DirectoryColor -Directory $Directory -DirectoryColors $global:AestheticConsoleColors.Filters.Directories)
        [string]$Icon = (Resolve-DirectoryIcon -Directory $Directory -DirectoryIcons $global:AestheticConsoleIcons.Filters.Directories)
        return ( "$ANSI$Icon " + $Directory.Name + "`e[0m/" )
    }
}