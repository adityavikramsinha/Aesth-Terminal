. "${global:AestheticConsoleModuleRoot}\Private\Resolve-FileColor"
. "${global:AestheticConsoleModuleRoot}\Private\Resolve-FileIcon"

Function Format-File {
    Param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $File
    )

    process {
        [string]$ANSI = (Resolve-FileColor -File $File -FileColors $global:AestheticConsoleColors.Filters.Files)
        $Icon = (Resolve-FileIcon -File $File -FileIcons $global:AestheticConsoleIcons.Filters.Files)
        return ( "$ANSI$Icon " + $File.Name + "`e[0m" )
    }
}
