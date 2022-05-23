$global:AestheticConsoleModuleRoot = $PSScriptRoot


Get-ChildItem -Path "${PSScriptRoot}\Public\" |
ForEach-Object -Process {
    . $_.FullName
}
# Importing Private functions
. "${PSScriptRoot}\Private\ParseToANSI.ps1"

# Path to the Icon Preferences for the current User
$global:PathToIconPreferences

# Path to the Color Preferences for the current User
$global:PathToColorPreferences 

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


Function Update-UserPreferences {
    $UserHashTable = @{
        "PathToIcons"  = "$global:PathToIconPreferences" ;
        "PathToColors" = "$global:PathToColorPreferences"
    }
    ( $UserHashTable | ConvertTo-JSON ) > "${PSScriptRoot}/Public/UserInfo.json"
}

Function Get-UserPreferences {
    $UserHashTable = ( Get-Content "${PSScriptRoot}/Public/UserInfo.json" )  | ConvertFrom-JSON -AsHashtable
    $global:PathToIconPreferences = $UserHashTable["PathToIcons"]
    $global:PathToColorPreferences = $userHashTable["PathToColors"]
}

Function Set-IconsPath{
    $CandidatePath = Read-Host -Prompt "Enter the path where the Icons customisation *.json is present"
    $Successful= $PSStyle.Foreground.Green
    if(Test-Path -Path $CandidatePath){
        $global:PathToIconPreferences = $CandidatePath
        Write-Output ($Successful+"Path of icon preferences succesfully to {0}" -f $global:PathToIconPreferences)
        Update-UserPreferences
    }
    else {
        Write-Error ("Path of icon preferences is not valid")
    }
}

Function Set-ColorsPath{
    $CandidatePath = Read-Host -Prompt "Enter the path where the Icons customisation *.json is present"
    $Successful = $PSStyle.Foreground.Green
    if (Test-Path -Path $CandidatePath) {
        $global:PathToColorPreferences = $CandidatePath
        Write-Output ($Successful + "Path of icon preferences succesfully to {0}" -f $global:PathToColorPreferences)
        Update-UserPreferences
    }
    else {
        Write-Error ("Path of icon preferences is not valid")
    }
}




Get-UserPreferences
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