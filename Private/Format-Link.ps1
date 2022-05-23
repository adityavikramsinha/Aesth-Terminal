Function Format-Link {
    Param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $Link
    )
    process {
        if ($Link.LinkType -eq "Junction") {
            $Icon = $global:AestheticConsoleIcons.Filters.junction
            $ANSI = $global:AestheticConsoleColors.Filters.junction
        }
        else {
            $Icon = $global:AestheticConsoleIcons.Filters.symlink
            $ANSI = $global:AestheticConsoleColors.Filters.symlink
        }
        $Target = $Link.LinkTarget
        return ( "$ANSI$Icon " + $Link.Name + "  " + $Target + "`e[0m" )
    }
}