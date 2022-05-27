Function Install-AestheticConsole{

    # Firstly, take the contents of the mock file and push it into the
    # the Aesthetic-Console.psm1 file.
    # After this, we delete that mock file since its work is done over-write
    # the .psm1 file with data.
    # Once this has been done, we need to point the path pointers to the given
    # default folder which has the default settings.

    # After this, we will delete this file and remove any other "bloat-ware"
    # to minimise the bundle.

    $Root = $PSScriptRoot
    $Root = $Root.Replace('\Removable' , '')
    $FreshContent = (Get-Content -Path "$Root\Removable\MockPsmFile.ps1" -Raw )
    $FreshContent > "$Root\Aesthetic-Console.psm1"

    $UserInfoHashTable= @{
        "PathToPreferences" = "$Root\Themes\defaultTheme.json"
    }

    ($UserInfoHashTable | ConvertTo-Json ) > "$Root\Public\settings.json"

    Write-Output ($PSStyle.Foreground.Green +"We have succesfully installed the Module Aesthetic-Console")
    Remove-Item -Path  "$Root\Removable\" -Recurse

}
