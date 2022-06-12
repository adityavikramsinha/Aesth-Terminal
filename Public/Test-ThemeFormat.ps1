<#

.SYNOPSIS
Tests a given json file against the schema for this json file.
If returns a true if the Test is successful and, false if the
Test is unsuccessful.

.DESCRIPTION
The schema is taken as a string and then the contents of the file
to validate from are taken as a whole.
This content is then held against the schema and checked for any
errors or such. If so then the function will return a false, or a mesage.
In both cases, the nessages can be stopped by just invoking the NoMsg flag.

.OUTPUTS
boolean value with true or false signifying the outcome of the test

.INPUTS
NoMsg is a boolean flag to supress messages
ThemePathToValidate is the path to the file

.EXAMPLE
Test-ThemeFormat -NoMsg -ThemePathToValidate "C:\Path\to\validate\file.json'"

#>
Function Test-ThemeFormat{
    [OutputType([boolean])]
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
    else {
        return $false
    }
}
