
<#

.SYNOPSIS
Converts a valid RGB hexcode [may or may not have the # symbol] to
its equivalent ANSI.

.DESCRIPTION
The function takes both parameter value as well as a pipeline value.
Any characters except for numbers[0-9] , letters [A-Z]|[a-z] and # and ' '
will give an error since the processor has not been programmed to
take care of those cases. Once, the whole RGB string has been
processed, it returns a [string] containing the ANSI which the
shell can execute. This is in the form of [38;2;r;g;b
The r stands for the Red part of the code
The g stands for the Green part of the code
The b stands for the Blue part of the code

.OUTPUTS
[string] containing the ANSI hexcode of a color

.INPUTS
[string]RGB - containing the RGB hexcode of a color

.EXAMPLE
$black = (ConvertFrom-RGB -RGB "#000000"
# tbe output will be [38;2;0;0;0

#>
Function ConvertFrom-RGB {
    [OutputType([string])]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$RGB
    )

    # Process to "perform" on every pipline or normal input
    # The logic for the below function is simple
    # First, it removes all the space and hash characters
    # Second, it It will feed the string position (0 -> 2)
    # to get the r. This is then done from (2 -> 2) to get g and,
    # from (4 -> 2) to get b.
    # Afterwards, this whole thing is prefixed with [38;2 and returned.
    process {
        # First replace all the "illegal" characters
        $RGB = $RGB.Replace('#', '')
        $RGB = $RGB.Trim()
        $RGB = $RGB.Replace(' ', '')

        # Assign the respective r , g , b values using the converter
        $r = [convert]::ToInt32($RGB.SubString(0, 2), 16)
        $g = [convert]::ToInt32($RGB.SubString(2, 2), 16)
        $b = [convert]::ToInt32($RGB.SubString(4, 2), 16)

        # Return the final string along with escape sequence
        return "[38;2;$r;$g;$b"
    }
}
