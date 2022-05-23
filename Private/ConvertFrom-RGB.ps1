function ConvertFrom-RGB {

    [OutputType([string])]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$RGB
    )

    process {
        # First replace all the "illegal" characters
        $RGB = $RGB.Replace('#', '')
        $RGB = $RGB.Trim()

        # Assign the respective r , g , b values using the converter
        $r = [convert]::ToInt32($RGB.SubString(0, 2), 16)
        $g = [convert]::ToInt32($RGB.SubString(2, 2), 16)
        $b = [convert]::ToInt32($RGB.SubString(4, 2), 16)

        # Return the final string along with escape sequence
        return "`e[38;2;$r;$g;$b`m"
    }
}