. "${global:AestheticConsoleModuleRoot}\Private\ConvertFrom-RGB.ps1"
Function Format-UserData{
    Param(
        [Parameter(Mandatory)]
        $table
    )
    foreach($key in $($table.Keys)){
        if(-not($table[$key] -is [System.Collections.Hashtable])) {
            if($key -eq "color"){
                $table[$key] = $(ConvertFrom-RGB ( $table[$key]) )
            }
        }
        else {
            Format-UserData -table ($table[$key])
        }
    }

}
