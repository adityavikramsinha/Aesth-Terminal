. "${global:AestheticConsoleModuleRoot}\Private\ConvertFrom-RGB.ps1"
. "${global:AestheticConsoleModuleRoot}\Private\ConvertFrom-Styles.ps1"

<#

.SYNOPSIS
Utility function which is used to convert the whole
user data's[the json customisation file] "color" property
into their ANSI equivalent codes.
#>
Function Format-Settings{
    Param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $table
    )
    foreach($key in $($table.Keys)){
        if(-not($table[$key] -is [System.Collections.Hashtable])) {
            if($key -eq 'color'){
                $table[$key] = $(ConvertFrom-RGB ( $table[$key]) )
            }
            elseif($key -eq 'styles') {
                for (($i = 0); $i -lt $table[$key].Length; ($i++)) {
                    $val = $table[$key][$i]
                    $table[$key][$i] = (ConvertFrom-Styles -style $val)
                }
            }
        }
        else {
            Format-Settings -table ($table[$key])
        }
    }
}
