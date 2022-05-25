# Replace the individual variables with just
# AestheticConsolePreferences.

# I have three filters
# each contains a default fall back
# that way, i have something to go to
# when no others are present,

# Function is ready to be implemented.

Function Format-AestheticConsole {
    Param(
        [Parameter(Mandatory , ValueFromPipeline)]
        $SysObject
    )

    begin {
        $color=''
        $icon=''
    }

    process {
        if($SysObject.LinkType -eq 'Junction'){
            if($global:AestheticConsolePreferences.Filters.Links.ContainsKey('junction')){
                if($global:AestheticConsolePreferences.Filters.Links.junction.ContainsKey('color')){
                    $color = $global:AestheticConsolePreferences.Filters.Links.junction.color
                }
                else {
                    $color = $global:AestheticConsolePreferences.Filters.Links.default.color
                }
                if($global:AestheticConsolePreferences.Filters.Links.junction.ContainsKey('icon')){
                    $icon = $global:AestheticConsolePreferences.Filters.Links.junction.icon
                }
                else {
                    $icon = $global:AestheticConsolePreferences.Filters.Links.default.icon
                }
            }
            else {
                $color = $global:AestheticConsolePreferences.Filters.Links.default.color
                $icon = $global:AestheticConsolePreferences.Filters.Links.default.icon
            }
            return ( "$color$icon " + $SysObject.Name + "  " + $SysObject.LinkTarget + "`e[0m" )
        }
        elseif($SysObject.LinkType -eq 'SymbolicLink'){
            if($global:AestheticConsolePreferences.Filters.Links.Containskey('symlink')){
                if($global:AestheticConsolePreferences.Filters.Links.symlink.ContainsKey('color')){
                    $color = $global:AestheticConsolePreferences.Filters.Links.symlink.color
                }
                else{
                    $color = $global:AestheticConsolePreferences.Filters.Links.default.color
                }
                if($global:AestheticConsolePreferences.Filters.Links.symlink.ContainsKey('icon')){
                    $icon = $global:AestheticConsolePreferences.Filters.Links.symlink.icon
                }
                else {
                    $icon = $global:AestheticConsolePreferences.Filters.Links.default.icon
                }
            }
            else{
                $color = $global:AestheticConsolePreferences.Filters.Links.default.color
                $icon  = $global:AestheticConsolePreferences.Filters.Links.default.icon
            }
            return ( "$color$icon " + $SysObject.Name + "  " + $SysObject.LinkTarget + "`e[0m" )
        }
        elseif($SysObject -is [System.IO.DirectoryInfo]){
            if($global:AestheticConsolePreferences.Filters.Directories.ContainsKey($SysObject.Name)){
                $tableEntry = $global:AestheticConsolePreferences.Filters.Directories[$SysObject.Name]
                if($tableEntry.ContainsKey('color')){
                    $color = $tableEntry.color
                }
                else {
                    $color = $global:AestheticConsolePreferences.Filters.Directories.default.color
                }
                if($tableEntry.ContainsKey('icon')){
                    $icon = $tableEntry.icon
                }
                else {
                    $icon = $global:AestheticConsolePreferences.Filters.Directories.default.icon
                }
            }
            else{
                $color = $global:AestheticConsolePreferences.Filters.Directories.default.color
                $icon = $global:AestheticConsolePreferences.Filters.Directories.default.icon
            }
            return ( "$color$icon " + $SysObject.Name + "`e[0m/" )
        }
        else {
            if($global:AestheticConsolePreferences.Filters.Files.ContainsKey($SysObject.Name)){
                $tableEntry = $global:AestheticConsolePreferences.Filters.Files[$SysObject.Name]
                if($tableEntry.ContainsKey('color')){
                    $color =  $tableEntry.color
                }
                else {
                    $color = $global:AestheticConsolePreferences.Filters.Files.default.color
                }
                if ($tableEntry.ContainsKey('icon')){
                    $icon= $tableEntry.icon
                }
                else {
                    $icon = $global:AestheticConsolePreferences.Filters.Files.default.icon
                }
            }
            elseif($global:AestheticConsolePreferences.Filters.Files.ContainsKey($SysObject.Extension)){
                $tableEntry = $global:AestheticConsolePreferences.Filters.Files[$SysObject.Extension]
                if ($tableEntry.ContainsKey('color')) {
                    $color = $tableEntry.color
                }
                else {
                    $color = $global:AestheticConsolePreferences.Filters.Files.default.color
                }
                if ($tableEntry.ContainsKey('icon')) {
                    $icon = $tableEntry.icon
                }
                else {
                    $icon = $global:AestheticConsolePreferences.Filters.Files.default.icon
                }
            }
            else {
                $color = $global:AestheticConsolePreferences.Filters.Files.default.color
                $icon = $global:AestheticConsolePreferences.Filters.Files.default.icon
            }
            return ( "$color$icon " + $SysObject.Name + "`e[0m" )
        }
        # End of script
    }
}
