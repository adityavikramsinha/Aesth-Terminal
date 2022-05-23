. "${global:AestheticConsoleModuleRoot}\Private\ConvertFrom-RGB.ps1"

Function ParseToANSI($h) {
    foreach ($k in $($h.Keys)) {
        if (-not( $h[$k] -is [System.Collections.HashTable])) {
            $h[$k] = $( ConvertFrom-RGB ( $h[$k] ) )
        }
        else {
            ParseToANSI($h[$k])
        }
    }
}