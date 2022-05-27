. "$AestheticConsoleModuleRoot\Private\ConvertFrom-Styles.ps1"

# Replace the individual variables with just
# AestheticConsolePreferences.

# I have three filters
# each contains a default fall back
# that way, i have something to go to
# when no others are present,

# Function has to be modified.
# Adding of [prefix,suffix] to the Json structure also
# needs to be present in the Format-AestheticConsole section
Function Format-AestheticConsole {
    Param(
        [Parameter(Mandatory , ValueFromPipeline)]
        $SysObject
    )

    begin {
        $color=''
        $icon=''
        $style = ''
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
                if($global:AestheticConsolePreferences.Filters.Links.junction.ContainsKey('styles')){
                    foreach($op in $global:AestheticConsolePreferences.Filters.Links.junction.styles){
                        if(!($op -eq '')){
                            $style = -join ($style,";", $op)
                        }
                    }
                }
            }
            else {
                $color = $global:AestheticConsolePreferences.Filters.Links.default.color
                $icon = $global:AestheticConsolePreferences.Filters.Links.default.icon
                if ($global:AestheticConsolePreferences.Filters.Links.default.ContainsKey('styles')) {
                    foreach ($op in $global:AestheticConsolePreferences.Filters.Links.junction.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }
            return ( "`e$color`m$icon `e$color$style`m" + $SysObject.Name + "  " + $SysObject.LinkTarget + "`e[0m" )
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
                if ($global:AestheticConsolePreferences.Filters.Links.symlink.ContainsKey('styles')) {
                    foreach ($op in $global:AestheticConsolePreferences.Filters.Links.symlink.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }
            else{
                $color = $global:AestheticConsolePreferences.Filters.Links.default.color
                $icon  = $global:AestheticConsolePreferences.Filters.Links.default.icon
                if ($global:AestheticConsolePreferences.Filters.Links.default.ContainsKey('styles')) {
                    foreach ($op in $global:AestheticConsolePreferences.Filters.Links.symlink.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }
            return ( "`e$color`m$icon `e$color$style`m" + $SysObject.Name + "  " + $SysObject.LinkTarget + "`e[0m" )
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
                if ($tableEntry.ContainsKey('styles')) {
                    foreach ($op in $tableEntry.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }
            else{
                $color = $global:AestheticConsolePreferences.Filters.Directories.default.color
                $icon = $global:AestheticConsolePreferences.Filters.Directories.default.icon
                if ($global:AestheticConsolePreferences.Filters.Directories.default.ContainsKey('styles')) {
                    foreach ($op in $global:AestheticConsolePreferences.Filters.Directories.default.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }
            return ( "`e$color`m$icon `e$color$style`m" + $SysObject.Name + "`e[0m/" )
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
                if ($tableEntry.ContainsKey('styles')) {
                    foreach ($op in $tableEntry.styles.keys) {
                        $style = -join ($style, ";", $op)
                    }
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
                if ($tableEntry.ContainsKey('styles')) {
                    foreach ($op in $tableEntry.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }
            else {
                $color = $global:AestheticConsolePreferences.Filters.Files.default.color
                $icon = $global:AestheticConsolePreferences.Filters.Files.default.icon
                if ($global:AestheticConsolePreferences.Filters.Files.default.ContainsKey('styles')) {
                    foreach ($op in $global:AestheticConsolePreferences.Filters.Files.default.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }
            return ( "`e$color`m$icon `e$color$style`m" + $SysObject.Name + "`e[0m" )
        }
        # End of script
    }
}
