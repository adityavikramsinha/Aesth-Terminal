Function Resolve-FileColor {

    [OutputType([string])]
    Param(
        [Parameter(Mandatory)]
        $File,
        [Parameter(Mandatory)]
        $FileColors
    )

    # Lastly a check to see priorities 2 - 4.
    if ($FileColors.ContainsKey($File.Name)) {
        return $FileColors[$File.Name]
    }
    elseif ($FileColors.ContainsKey($File.Extension)) {
        return $FileColors[$File.Extension]
    }
    else {
        return $FileColors.default
    }
}