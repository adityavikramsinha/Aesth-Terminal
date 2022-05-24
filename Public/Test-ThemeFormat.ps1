Function Test-ThemeFormat{
    Param(
        [switch]$NoMsg,
        [Parameter(Mandatory, ValueFromPipeline)]
        $ThemePathToValidate
    )

    $Schema = @'
    {
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties": {
        "Filters": {
            "type": "object",
            "properties": {
                "junction": {
                    "type": "string"
                },
                "symlink": {
                    "type": "string"
                },
                "Directories": {
                    "type": "object",
                    "properties": {
                        "default": {
                            "type": "string"
                        }
                    },
                    "required": [
                    "default"
                    ]
                },
                "Files": {
                    "type": "object",
                    "properties": {
                        "default": {
                            "type": "string"
                        }
                    },
                    "required": [
                    "default"
                    ]
                }
            },
            "required": [
            "junction",
            "symlink",
            "Directories",
            "Files"
            ]
        }
    },
    "required": [
    "Filters"
    ]
}
'@
    try{
        $InvestigationConclusion = ( Test-Json -Json (Get-Content $ThemePathToValidate -Raw ) -Schema $Schema )
        if($NoMsg){
            return $true
        }
        else{
            Write-Output ($PSStyle.Foreground.Green+"YAY!!The theme is ready to be implemented" )
        }
    }
    catch{
        Write-Output "Could not process the file because of a system error. "
    }
}