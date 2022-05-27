<#

.SYNOPSIS
Converts common styles such as [italic,bold,underlined,strike-through]
to their ANSI equivalents which can be implemeted by the shell

.DESCRIPTION
Given an input string containing a style, this function retuns
just the ANSI code of that style from its internal hashtable.

.INPUTS
[string]style - is the style that needs to be mapped to its ANSI code

.OUTPUTS
[string] containing the ANSI code of the given input style

.EXAMPLE
$italic = (ConvertFrom-Styles -style 'italic')

#>

Function ConvertFrom-Styles {
    [OutputType([string])]
    Param (
        [Parameter(Mandatory , ValueFromPipeline)]
        [string]$style
    )

    # Sets up the starting hashtable containing
    # as list of mappings for available styles and
    # their ANSI code equivalents.
    begin {
        $Styleshash = @{
            'italic'         = '3'
            'bold'           = '1'
            'underline'      = '4'
            'strike-through' = '9'
        }
    }

    # The logical mapping of each style from its key
    # to it ANSI value. Incase the key does not exist,
    # an empty string is returned.
    process {

        if ($Styleshash.ContainsKey($style)) {
            return $Styleshash[$style]
        }
        else {
            Write-Warning  @"
[From Aesthetic-Console Module]
`nThere seems to be something wrong in the style $style,
the possible values for the styles are $($Styleshash.Keys)
"@
            return ''
        }
    }
}
