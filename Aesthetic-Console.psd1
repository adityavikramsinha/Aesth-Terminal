@{
    RootModule        = 'Aesthetic-Console.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'ba405025-a2bd-4295-b518-e0fa2715221e'
    Author            = 'aditya vikram sinha [adityavikramsinha19@gmail.com]'
    Description       = 'My personal console beautifier and for output formatting'
    RequiredModules   = @()
    VariablesToExport = @()
    CmdletsToExport   = @()
    AliasesToExport   = @()
    FunctionsToExport = @(
        'Set-Information',
        'Format-AestheticConsole',
        'Set-PreferencesPath',
        'Test-ThemeFormat',
        'Install-AestheticConsole',
        'Format-Settings'
    )

    # Gave an error when I tried to put the values.
    # Error was :The module manifest Path/to/module/manifest
    # could not be processed because it is not a valid PowerShell module manifest file.
    # Remove the elements that are not permitted: At Path/to/module/manifest :20 char:9
    # PSData = @(
    # The command 'PSData' is not allowed in restricted language mode or a Data section.
    #At Path/to/module/manifest.psd1:21 char:13 Tag =@('Color', 'Terminal', 'Console', 'NerdFont'
    # The command 'Tags' is not allowed in restricted language mode or a Data section.
    PrivateData = @()
}