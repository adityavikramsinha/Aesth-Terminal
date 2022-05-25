# Setting up the module root, this will help in
# associating qualified[absolute] paths in a
# relative fashion,
$global:AestheticConsoleModuleRoot = $PSScriptRoot


# Import all the public scripts required from the
# Public Folder. This does not include the JSON
# File.
Get-ChildItem -Path "${PSScriptRoot}\Public\" |
ForEach-Object -Process {
    . $_.FullName
}

# Importing the utility function to help
# with pre-processing user information
. "${PSScriptRoot}\Private\Format-UserData.ps1"

# Path to the Icon Preferences for the current User
$global:PathToIconPreferences

# Path to the Color Preferences for the current User
$global:PathToColorPreferences

# HashTable containing all the Icons for Directories and Files are raw icons from NF (Nerd-Font)
$global:AestheticConsoleIcons = @()

# HashTable containing all the Colors for Directories and Files in RGB format
$global:AestheticConsoleColors = @()


# "Sets" the information for the current user.
# The meaning of this statement is that,
# global variables like AestheticConsoleIcons and AestheticConsoleColors
# will have different or same values depending on the contents of the JSON file
# which is being pointed to at by the global variable PathToIconPreferences and
# PathToColorPreferences.
# It then, pre-computes the color preferences to their ANSI equivalent.
# If any error is found, a message is displayed.
Function Set-Information {

    # First we try to put in all the valid information
    # regarding the user input. If for any reason,
    # the JSON parser fails, we give the most-recent
    # Error message.
    try {
        $global:AestheticConsoleIcons = ( Get-Content -Path $PathToIconPreferences) | ConvertFrom-Json -AsHashtable
        $global:AestheticConsoleColors = ( Get-Content -Path $PathToColorPreferences) | ConvertFrom-Json -AsHashtable

        # Parse The Hashtable from RGB to ANSI
        Format-UserData -table ($global:AestheticConsoleColors)
    }

    # Writes the Error to the console.
    catch {
        Write-Error -Exception $Error[0]
    }
}


# Updates the UserInfo.json file present in the
# Public folder. This will just write the
# given Path variables as a JSON which can later
# be parsed by the Get-UserPreferences function
Function Set-UserPreferences {

    # Construct a temporary hashtable with the
    # current variable values [fresh or stale]
    # and then write them to the UserInfo.json file
    $UserHashTable = @{
        "PathToIcons"  = "$global:PathToIconPreferences" ;
        "PathToColors" = "$global:PathToColorPreferences"
    }
    ( $UserHashTable | ConvertTo-JSON ) > "${PSScriptRoot}/Public/UserInfo.json"
}


# "Gets" the preferences of the user
# The logic is simple. It will try to load the resources
# Upon success it simply updates the variables to their new value
# If there is an error, it prints it to the console and returns.
Function Get-UserPreferences {

    # Tries to load the "resource".
    # This is just a hashtable with the user information
    # It contains the paths stored.
    # Now there can be multiple issues.
    # The first one is if the file does not exist.
    # The second one if it exists but has been corrupted
    # Both of these are taken care of, since relevant information
    # and error messages are printed to the console.
    try {
        $UserHashTable = ( Get-Content "${PSScriptRoot}/Public/UserInfo.json" )  | ConvertFrom-JSON -AsHashtable
    }

    # Catch the error and print a relevant message to the Console.
    catch {
        [string]$Message = "There was an issue trying to parse ${PSScriptRoot}/Public/UserInfo.json file."
        [string]$Recommendation = "The file might not be present or,may have been corrupted with information not parseable."
        Write-Error -Message $Message -RecommendedAction $Recommendation
        return
    }

    # Finally, we do not update the paths to their new variables if
    # The function gives an error.
    # If the function does not give an error, then we proceed and update
    # them.
    $global:PathToIconPreferences = $UserHashTable["PathToIcons"]
    $global:PathToColorPreferences = $userHashTable["PathToColors"]
}


# Sets the pointer for the icons preferences to a given path
# This performs two checks, one to see if the path is valid and another
# to check if the format of the JSON document in the path is valid using the
# given json schema.
# If all goes well then it will Print a success message
# If not, it prints the error message for the error it encountered.
Function Set-IconsPath {

    # Fist take the "proposed" path from the user.
    # Upon getting the path, we will try to first validate if it is correct
    # Perform a simple check as to whether the path exists.
    # Then it will check for a JSON-Schema based validation to match
    # If it does, the $PathToIconPreferences is updated and a relevant message is given
    # Then the whole information is written using the Set-UserPreferences function.
    $CandidatePath = Read-Host -Prompt "Enter the path where the Icons customisation *.json is present"

    # This is the green color. It is used for the valid path message.
    $Successful = $PSStyle.Foreground.Green

    if ( ( Test-Path -Path $CandidatePath ) -and ( Test-ThemeFormat -ThemePathToValidate $CandidatePath -NoMsg)) {
        $global:PathToIconPreferences = $CandidatePath
        Write-Output ($Successful + "Path of icon preferences succesfully to {0}" -f $global:PathToIconPreferences)
        Set-UserPreferences
    }

    # If it has not been validated, we just write that the Path is not valid.
    else {
        Write-Error ("Path of icon preferences is not valid")
    }
}

# Sets the pointer for the Color preferences to a given path
# This performs two checks, one to see if the path is valid and another
# to check if the format of the JSON document in the path is valid using the
# given json schema.
# If all goes well then it will Print a success message
# If not, it prints the error message for the error it encountered.
Function Set-ColorsPath {

    # Fist take the "proposed" path from the user.
    # Upon getting the path, we will try to first validate if it is correct
    # Perform a simple check as to whether the path exists.
    # If it does, the $PathToColorPreferences is updated and a relevant message is given
    # Then the whole information is written using the Set-UserPreferences function.
    $CandidatePath = Read-Host -Prompt "Enter the path where the Icons customisation *.json is present"

    # This is the green color. It is used for the valid path message.
    $Successful = $PSStyle.Foreground.Green

    if ( ( Test-Path -Path $CandidatePath ) -and ( Test-ThemeFormat -ThemePathToValidate $CandidatePath -NoMsg)) {
        $global:PathToColorPreferences = $CandidatePath
        Write-Output ($Successful + "Path of icon preferences succesfully to {0}" -f $global:PathToColorPreferences)
        Set-UserPreferences
    }

    # If it has not been validated, we just write that the Path is not valid.
    else {
        Write-Error ("Path of color preferences is not valid")
    }
}


# Calling the Get-UserPreferences function to update for changes
# This will automatically update all the global path variables being used.
Get-UserPreferences


# After this, We will have to perform the necessary checks for the
# theme we want to implement. The schema used has been given in the
# Test-ThemeFormat Function.
Test-ThemeFormat -ThemePathToValidate $global:PathToIconPreferences -NoMsg
Test-ThemeFormat -ThemePathToValidate $global:PathToColorPreferences -NoMsg


# Performing the necessary checks required for setting the information.
# If all is fine, then it goes forward with its work and adds the *.format.ps1xml script.
# It will also set the relevant information for the current preferences of the user
if ((($global:PathToIconPreferences) -and ($global:PathToColorPreferences)) -or
    (Test-Path $global:PathToIconPreferences) -and (Test-Path $global:PathToColorPreferences)) {
    Set-Information
    Update-FormatData -PrependPath "$PSScriptRoot\Aesthetic-Console.format.ps1xml"
}


# Upon failure. We quietly print a message to the console
# Then exit the script and not hinder the users experience.
else {
    Write-Output ($PSStyle.Foreground.Red +
        @"
    Paths cannot be resolved because either or both are invalid. You should probably try running Set-IconsPath and Set-ColorsPath again
"@)
}
