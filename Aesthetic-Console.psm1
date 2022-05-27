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
. "${PSScriptRoot}\Private\Format-Settings.ps1"

# Hashtble representation of the json file containing the user data
$global:AestheticConsolePreferences = @()

# Path to the json file containing the user data
$global:PathToPreferences

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
        $global:AestheticConsolePreferences = (Get-Content -Path $PathToPreferences ) | ConvertFrom-Json -AsHashtable

        # Parse The Hashtable from RGB to ANSI
        Format-Settings -table $AestheticConsolePreferences.Filters
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
        "PathToPreferences" = "$global:PathToPreferences"
    }
    ( $UserHashTable | ConvertTo-JSON ) > "${PSScriptRoot}/Public/settings.json"
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
        $UserHashTable = ( Get-Content "${PSScriptRoot}/Public/settings.json" )  | ConvertFrom-JSON -AsHashtable
    }

    # Catch the error and print a relevant message to the Console.
    catch {
        [string]$Message = "There was an issue while trying to parse ${PSScriptRoot}/Public/settings.json file."
        [string]$Recommendation = "The file might not be present or,may have been corrupted with information not parseable."
        Write-Error -Message $Message -RecommendedAction $Recommendation
        return
    }

    # Finally, we do not update the paths to their new variables if
    # The function gives an error.
    # If the function does not give an error, then we proceed and update
    # them.
    $global:PathToPreferences = $UserHashTable['PathToPreferences']
}

# Sets the pointer for the Color preferences to a given path
# This performs two checks, one to see if the path is valid and another
# to check if the format of the JSON document in the path is valid using the
# given json schema.
# If all goes well then it will Print a success message
# If not, it prints the error message for the error it encountered.
Function Set-PreferencesPath {

    # Fist take the "proposed" path from the user.
    # Upon getting the path, we will try to first validate if it is correct
    # Perform a simple check as to whether the path exists.
    # If it does, the $PathToColorPreferences is updated and a relevant message is given
    # Then the whole information is written using the Set-UserPreferences function.
    $CandidatePath = Read-Host -Prompt "Enter the path where customisation file *.json is present"

    # This is the green color. It is used for the valid path message.
    $Successful = $PSStyle.Foreground.Green

    if ( ( Test-Path -Path $CandidatePath ) -and ( Test-ThemeFormat -ThemePathToValidate $CandidatePath -NoMsg)) {
        $global:PathToPreferences = $CandidatePath
        Write-Output ($Successful + "Path for customisation preferences changed succesfully to {0}" -f $global:PathToPreferences)
        Set-UserPreferences
    }

    # If it has not been validated, we just write that the Path is not valid.
    else {
        Write-Error ("Path of color preferences is not valid or, the schema is not valid in the .json file")
    }
}


# Calling the Get-UserPreferences function to update for changes
# This will automatically update all the global path variables being used.
Get-UserPreferences


# After this, We will have to perform the necessary checks for the
# theme we want to implement. The schema used has been given in the
# Test-ThemeFormat Function.
Test-ThemeFormat -ThemePathToValidate $global:PathToPreferences -NoMsg


# Performing the necessary checks required for setting the information.
# If all is fine, then it goes forward with its work and adds the *.format.ps1xml script.
# It will also set the relevant information for the current preferences of the user
if ((-not ($null -eq $global:PathToPreferences))-and (Test-Path $global:PathToPreferences)){
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

