Function Resolve-DirectoryIcon {

    [OutputType([string])]
    Param(
        [Parameter(Mandatory)]
        $Directory,
        [Parameter(Mandatory)]
        [System.Collections.Hashtable]
        $DirectoryIcons
    )

    # Check the CustomisedIcons HashTable to see if there are any matches with
    # The literal name or just return the default icon for a Directory.
    if ($DirectoryIcons.ContainsKey($Directory.Name)) {
        return $DirectoryIcons[$Directory.Name]
    }
    else {
        return $DirectoryIcons.default
    }
}