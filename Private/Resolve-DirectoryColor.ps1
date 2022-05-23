function Resolve-DirectoryColor {
    [OutputType([string])]
    Param(
        [Parameter(Mandatory)]
        $Directory,
        [Parameter(Mandatory)]
        $DirectoryColors
    )

    if ($DirectoryColors.ContainsKey($Directory.Name)) {
        return $DirectoryColors[$Directory.Name]
    }
    else {
        return $DirectoryColors.default
    }
}
