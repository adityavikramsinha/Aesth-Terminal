Function Resolve-FileIcon {
    [OutputType([string])]
    Param(
        [Parameter(Mandatory)]
        $File,
        [Parameter(Mandatory)]
        [System.Collections.Hashtable]
        $FileIcons
    )
    if ($FileIcons.ContainsKey($File.Name)) {
        return $FileIcons[$File.Name]
    }
    elseif ($FileIcons.ContainsKey($File.Extension)) {
        return $FileIcons[$File.Extension]
    }
    else {
        return $FileIcons.default
    }
}
