Function Remove-AestheticConsole{
    $UserInput = "N"
    Write-Output ($PSStyle.Foreground.Red+
@"
    Hello, this is the Aesthetic-Console uninstaller. Are you sure you would like to uninstall this module ?`n
    We are so sorry that you are uninstalling this module. Incase, this did not match your expectations or standard
    please feel free to go to the github page and leave suggestions.

"@
)
    $Root = ($PSScriptRoot).Replace('\Public' , '')
    $UserInput = Read-Host "Type [Y]es to proceed with uninstallation. Default is [N]o"
    if($UserInput -eq "Y") {
        Remove-Item "$Root" -Recurse
        Write-Output ($PSStyle.Foreground.Green + "Uninstallation has been completed.Bye :(")
    }
    Write-Output "Eeeeh!Didnt delete it after all (:"
}
