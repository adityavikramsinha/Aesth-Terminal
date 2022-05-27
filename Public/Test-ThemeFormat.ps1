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
        "Links": {
          "type": "object",
          "properties": {
            "default": {
              "type": "object",
              "properties": {
                "icon": {
                  "type": "string"
                },
                "color": {
                  "type": "string"
                }
              },
              "required": [
                "icon",
                "color"
              ]
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
              "type": "object",
              "properties": {
                "color": {
                  "type": "string"
                },
                "icon": {
                  "type": "string"
                }
              },
              "required": [
                "color",
                "icon"
              ]
            }
          },
          "required": [
            "default"
          ]
        },
        "Directories": {
          "type": "object",
          "properties": {
            "default": {
              "type": "object",
              "properties": {
                "color": {
                  "type": "string"
                },
                "icon": {
                  "type": "string"
                }
              },
              "required": [
                "color",
                "icon"
              ]
            }
          },
          "required": [
            "default"
          ]
        }
      },
      "required": [
        "Links",
        "Files",
        "Directories"
      ]
    }
  },
  "required": [
    "Filters"
  ]
}
'@
    if(Test-Json -Json (Get-Content $ThemePathToValidate -Raw ) -Schema $Schema ){
        if ($NoMsg) {
            return $true
        }
        else {
            Write-Output ($PSStyle.Foreground.Green + "YAY!!The theme is ready to be implemented" )
        }
    }
}
