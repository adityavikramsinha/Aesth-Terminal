. "$AestheticConsoleModuleRoot\Private\ConvertFrom-Styles.ps1"


<#

.SYNOPSIS
Formats the output for any command which uses
the Get-ChildItem

.DESCRIPTION
Formats the output for a command by giving the Name
column the following properties[inorder]

<color><icon><color><style><$_.Name>
Where: $_ is the ValueFromPipeline

.EXAMPLE
Get-ChildItem | Format-AestheticConsole

#>
Function Format-AestheticConsole {
    Param(
        [Parameter(Mandatory , ValueFromPipeline)]
        $SysObject
    )

    # starting values are set to nothing
    # when the variables are given through pipeline.
    begin {
        $color=''
        $icon=''
        $style = ''
    }

    process {

        # checking for if the type is a junction
        if($SysObject.LinkType -eq 'Junction'){

            # checking for if the preferences contain a junction key
            if($global:AestheticConsolePreferences.Filters.Links.ContainsKey('junction')){

                # checking for if the junction contains a color key
                # if yes, then directly assign
                # if no, fall back to default.
                if($global:AestheticConsolePreferences.Filters.Links.junction.ContainsKey('color')){
                    $color = $global:AestheticConsolePreferences.Filters.Links.junction.color
                }
                else {
                    $color = $global:AestheticConsolePreferences.Filters.Links.default.color
                }

                # checking for if the junction key contains an icon key
                # if yes, we assign that
                # else we fall back to default under Links
                if($global:AestheticConsolePreferences.Filters.Links.junction.ContainsKey('icon')){
                    $icon = $global:AestheticConsolePreferences.Filters.Links.junction.icon
                }
                else {
                    $icon = $global:AestheticConsolePreferences.Filters.Links.default.icon
                }

                # checking for styles
                # if present, we compile the styles
                # else we do not do anything.
                if($global:AestheticConsolePreferences.Filters.Links.junction.ContainsKey('styles')){
                    foreach($op in $global:AestheticConsolePreferences.Filters.Links.junction.styles){
                        if(!($op -eq '')){
                            $style = -join ($style,";", $op)
                        }
                    }
                }
            }

            # fall back defaults for the Link
            # if styles is not present, just gloss over it.
            else {
                $color = $global:AestheticConsolePreferences.Filters.Links.default.color
                $icon = $global:AestheticConsolePreferences.Filters.Links.default.icon
                if ($global:AestheticConsolePreferences.Filters.Links.default.ContainsKey('styles')) {
                    foreach ($op in $global:AestheticConsolePreferences.Filters.Links.junction.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }

            # returning directly instead of in the end.
            return ( "`e$color`m$icon `e$color$style`m" + $SysObject.Name + "  " + $SysObject.LinkTarget + "`e[0m" )
        }

        # Now the other option is checking for a symlink [symbolic link]
        # if true, it gets into this branch.
        elseif($SysObject.LinkType -eq 'SymbolicLink'){

            # Check for if a symlink key exists.
            # if yes, get in
            # if not, fall back to defaults.
            if($global:AestheticConsolePreferences.Filters.Links.Containskey('symlink')){

                # check for if a color key exists
                # if yes, get in
                # it not, fall back to defaults
                if($global:AestheticConsolePreferences.Filters.Links.symlink.ContainsKey('color')){
                    $color = $global:AestheticConsolePreferences.Filters.Links.symlink.color
                }
                else{
                    $color = $global:AestheticConsolePreferences.Filters.Links.default.color
                }

                # check for if an icon key exists
                # if yes, get in
                # it not, fall back to defaults
                if($global:AestheticConsolePreferences.Filters.Links.symlink.ContainsKey('icon')){
                    $icon = $global:AestheticConsolePreferences.Filters.Links.symlink.icon
                }
                else {
                    $icon = $global:AestheticConsolePreferences.Filters.Links.default.icon
                }

                # check for if a styles key exists
                # if yes, compile the styles
                # else just gloss over it.
                if ($global:AestheticConsolePreferences.Filters.Links.symlink.ContainsKey('styles')) {
                    foreach ($op in $global:AestheticConsolePreferences.Filters.Links.symlink.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }

            # Incase the symlink key does not exist
            # get defaults
            else{
                $color = $global:AestheticConsolePreferences.Filters.Links.default.color
                $icon  = $global:AestheticConsolePreferences.Filters.Links.default.icon

                # if styles key exists
                # compile it
                # else dont,
                if ($global:AestheticConsolePreferences.Filters.Links.default.ContainsKey('styles')) {
                    foreach ($op in $global:AestheticConsolePreferences.Filters.Links.symlink.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }

            # return upon completion.
            return ( "`e$color`m$icon `e$color$style`m" + $SysObject.Name + "  " + $SysObject.LinkTarget + "`e[0m" )
        }

        # Checking for if it is a directory
        # If yes, get into this branch
        elseif($SysObject -is [System.IO.DirectoryInfo]){

            # checking for if the preferences has the name
            # if yes, get in
            # it not, fall back to defaults
            if($global:AestheticConsolePreferences.Filters.Directories.ContainsKey($SysObject.Name)){
                $tableEntry = $global:AestheticConsolePreferences.Filters.Directories[$SysObject.Name]

                # checking for if the color key is present or not
                # if yes, get in
                # it not, fall back to defaults
                if($tableEntry.ContainsKey('color')){
                    $color = $tableEntry.color
                }
                else {
                    $color = $global:AestheticConsolePreferences.Filters.Directories.default.color
                }

                # checking for if the icon key is present or not
                # if yes, get in
                # it not, fall back to defaults
                if($tableEntry.ContainsKey('icon')){
                    $icon = $tableEntry.icon
                }
                else {
                    $icon = $global:AestheticConsolePreferences.Filters.Directories.default.icon
                }

                # Upon reaching styles,
                # if it exists
                # compile it
                # else dont
                if ($tableEntry.ContainsKey('styles')) {
                    foreach ($op in $tableEntry.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }

            # falling back to defaults
            else{

                # color and icons compilation
                $color = $global:AestheticConsolePreferences.Filters.Directories.default.color
                $icon = $global:AestheticConsolePreferences.Filters.Directories.default.icon

                # compile styles if present
                # else dont
                if ($global:AestheticConsolePreferences.Filters.Directories.default.ContainsKey('styles')) {
                    foreach ($op in $global:AestheticConsolePreferences.Filters.Directories.default.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }

            # directly returns.
            return ( "`e$color`m$icon `e$color$style`m" + $SysObject.Name + "`e[0m/" )
        }

        # Lastly, it HAS to be a file.
        else {

            # First we check for the case wherein the preferences have a name
            if($global:AestheticConsolePreferences.Filters.Files.ContainsKey($SysObject.Name)){

                # get the name
                # this reduces boiler plate code.
                $tableEntry = $global:AestheticConsolePreferences.Filters.Files[$SysObject.Name]

                # checking for the color key
                # if yes, get in
                # it not, fall back to defaults
                if($tableEntry.ContainsKey('color')){
                    $color =  $tableEntry.color
                }
                else {
                    $color = $global:AestheticConsolePreferences.Filters.Files.default.color
                }

                # checking for the icon key
                # if yes, get in
                # it not, fall back to defaults
                if ($tableEntry.ContainsKey('icon')){
                    $icon= $tableEntry.icon
                }
                else {
                    $icon = $global:AestheticConsolePreferences.Filters.Files.default.icon
                }

                # checking for styles
                # if found then compile
                # else gloss over
                if ($tableEntry.ContainsKey('styles')) {
                    foreach ($op in $tableEntry.styles.keys) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }

            # now we check for the extension
            # if yes, get in
            # it not, fall back to defaults
            # note, we take the last extension only
            # if a file is like <filename>.<ext1>.<ext2>,
            # then .ext2 is the one taken into account
            elseif($global:AestheticConsolePreferences.Filters.Files.ContainsKey($SysObject.Extension)){

                # again
                # variable made to reduce boiler plate
                $tableEntry = $global:AestheticConsolePreferences.Filters.Files[$SysObject.Extension]

                # get the color key from the extension
                # if yes, get in
                # it not, fall back to defaults
                if ($tableEntry.ContainsKey('color')) {
                    $color = $tableEntry.color
                }
                else {
                    $color = $global:AestheticConsolePreferences.Filters.Files.default.color
                }

                # next, we look for the icon key
                # if yes, get in
                # it not, fall back to defaults
                if ($tableEntry.ContainsKey('icon')) {
                    $icon = $tableEntry.icon
                }
                else {
                    $icon = $global:AestheticConsolePreferences.Filters.Files.default.icon
                }

                # for styles
                # if present, compile the styles
                # else just dont bother.
                if ($tableEntry.ContainsKey('styles')) {
                    foreach ($op in $tableEntry.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }

            # lastly
            # default fallbacks for
            # if neither are present.
            else {
                $color = $global:AestheticConsolePreferences.Filters.Files.default.color
                $icon = $global:AestheticConsolePreferences.Filters.Files.default.icon
                if ($global:AestheticConsolePreferences.Filters.Files.default.ContainsKey('styles')) {
                    foreach ($op in $global:AestheticConsolePreferences.Filters.Files.default.styles) {
                        $style = -join ($style, ";", $op)
                    }
                }
            }

            # return everything packed.
            return ( "`e$color`m$icon `e$color$style`m" + $SysObject.Name + "`e[0m" )
        }
    }
}
