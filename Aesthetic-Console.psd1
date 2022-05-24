@{
    RootModule = 'Aesthetic-Console.psm1'
    ModuleVersion = '1.0.0'
    GUID  = 'ba405025-a2bd-4295-b518-e0fa2715221e'
    Author = 'aditya vikram sinha [adityavikramsinha19@gmail.com]'
    Description = 'My personal console beautifier and for output formatting'
    RequiredModules = @()
    VariablesToExport = @()
    CmdletsToExport   = @()
    AliasesToExport   = @()
    FunctionsToExport = @(
        'Set-Information',
        'Format-AestheticConsole',
        'Set-IconsPath',
        'Set-ColorsPath',
        'Test-ThemeFormat'
    )
    # Will have to get this from the github repo
    PrivateData = @()
}