. "${global:AestheticConsoleModuleRoot}\Private\ConvertFrom-RGB.ps1"
. "${global:AestheticConsoleModuleRoot}\Private\ConvertFrom-Styles.ps1"

<#

.SYNOPSIS
Utility function which is used to convert the whole
user data's[the json customisation file] "color" and "styles" property
into their ANSI equivalent codes.

.DESCRIPTION
This is a utility function which helps to change the theme data from
RGB[in case of color] to ansi and from styles [such as italic, bold] to
also ansi so that they can be compiled by the Console at once.
This helps in precomputation since no more requirement of a separate
function call is required.

.EXAMPLE
Format-Settings -table $UserInfoHashTable

.INPUTS
A hashtable containing the values of the user information

.OUTPUTS
It modifies the actual hashtable implace, so nothing is given
out as output.

#>
Function Format-Settings{

    Param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [Hashtable]
        $table
    )

    # Logic is simple. We go through the the whole collection and then
    # if we come across a property with the name of color then we convert
    # it from rgb to ansi. If we get a key with the name of styles, we
    # loops over the whole styles array and convert the styles into their
    # ansi equivalent.
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
