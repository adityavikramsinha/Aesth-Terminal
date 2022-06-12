<#

.SYNOPSIS
Removes the Aesthetic-Console module from the user current
powershell path

.DESCRIPTION
Removes the Aesthetic-Console from the users current pwershell
modules path. This is done after the user says Y to the prompt given.
The default i N or no.

.EXAMPLE
Remove-AestheticConsole

#>
Function Remove-AestheticConsole{
    [String]$UserInput = "N"

    # Display message.
    Write-Output ($PSStyle.Foreground.Yellow+
@"
    Hello, this is the Aesthetic-Console uninstaller. Are you sure you would like to uninstall this module ?1n
    We are so sorry that you are uninstalling this module. Incase, this did not match your expectations or standard
    please feel free to go to the github page and leave suggestions.

"@
)
    # Example look should be "C:\Users\UserName\Path\To\Powershell\Module\Aesthetic-Console"
    [String]$Root = ($PSScriptRoot).Replace('\Public' , '')
    [String]$UserInput = Read-Host "Type [Y]es to proceed with uninstallation. Default is [N]o"

    # On Yes
    if($UserInput -eq "Y") {
        Remove-Item "$Root" -Recurse
        Write-Output ($PSStyle.Foreground.Yellow + "Uninstallation has been completed.Bye :(")
        return
    }

    # on No
    Write-Output "$($PSStyle.Foreground.Green)Eeeeeeh!You did not uninstall after all :)"
}
