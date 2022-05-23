$global:AestheticConsoleModuleRoot = $PSScriptRoot


Get-ChildItem -Path "${PSScriptRoot}\Public\" |
ForEach-Object -Process {
    . $_.FullName
}
# Importing Private functions
. "${PSScriptRoot}\Private\ParseToANSI.ps1"
# . "${PSScriptRoot}\Private\Resolve-DirectoryColor.ps1"
# . "${PSScriptRoot}\Private\Resolve-FileColor.ps1"
# . "${PSScriptRoot}\Private\Resolve-DirectoryIcon .ps1"

# Path to the Icon Preferences for the current User
$global:PathToIconPreferences = "C:\Users\adi\.config\shellconfigs\powershell_core\pwsh_core_terminal_icon_themes.json"

# Path to the Color Preferences for the current User
$global:PathToColorPreferences = "C:\Users\adi\.config\shellconfigs\powershell_core\pwsh_core_terminal_color_themes.json"

# HashTable containing all the Icons for Directories and Files are raw icons from NF (Nerd-Font)
$global:AestheticConsoleIcons= @()

# HashTable containing all the Colors for Directories and Files in RGB format
$global:AestheticConsoleColors = @()

# List of Icons and Colors related to the File type
$script:FileColors = @()
$script:FileIcons = @()

# List of Icons and Colors related to System.IO.Directory
$script:DirectoryIcons = @()
$script:DirectoryIcons = @()

$global:CopiedHashtable = @()


Function Set-Information {
    try {
        $global:AestheticConsoleIcons = ( Get-Content -Path $PathToIconPreferences) | ConvertFrom-Json -AsHashtable
        $global:AestheticConsoleColors = ( Get-Content -Path $PathToColorPreferences) | ConvertFrom-Json -AsHashtable
        # Parse The Hashtable from RGB to ANSI
        ParseToANSI($global:AestheticConsoleColors)
        $script:FileColors = $global:AestheticConsoleIcons.Filters.Files
        $script:FileIcons = $global:AestheticConsoleIcons.Filters.Files
        $script:DirectoryColors = $global:AestheticConsoleColors.Filters.Directores
        $script:DirectoryIcons = $global:AestheticConsoleIcons.Filters.Directories
    }
    catch {
        Write-Error -Exception $Error[0]
    }
}

Set-Information
Update-FormatData -PrependPath "$PSScriptRoot\Aesthetic-Console.format.ps1xml"


Function Format-AestheticConsole{
    Param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $fObj
    )
    if ($fObj.LinkType -eq "Junction" -or $fObj.LinkType -eq "SymbolicLink"){
        Format-Link -Link $fObj
    }
    elseif ($fObj -is [System.IO.DirectoryInfo]) {
        Format-Directory -Directory $fObj
    }
    else {
        Format-File -File $fObj
    }
}

Function Print {
    Format-AestheticConsole -fObj (Get-Item "C:\Users\adi\Cookies " -Force)
}