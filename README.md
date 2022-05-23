## Aesthetic-Console

#### Author : aditya vikram sinha , <adityavikramsinha19@gmail.com>

#### Inspiration[s](preceeding repositories)

[Terminal-Icons](https://github.com/devblackops/Terminal-Icons) ,
[DirColors](https://github.com/DHowett/DirColors)

This project is most certainly not **original**. There are people who have done this before and in a sense, _in a better way_. However, this is not the point of this project. This project was a **personal** one to help me understand the way powershell works and also, because i was _obsessed_ with customising my powershell from the bottom up.

Most of this project works based on the .format.ps1xml configuration given my Microsoft natively. It has been taken from the [Terminal-Icons](https://github.com/devblackops/Terminal-Icons) repository which in turn took it from [DirColors](https://github.com/DHowett/DirColors). Quite conviniently, this project has been named as **Aesthetic-Console** and uses*.json config files to catch user input. A normal user can have it located anywhere in their computer. The only important distinction is that it needs to be _for now_ manually inserted to the [Aesthetic-Console.psm1](https://github.com/codeadityavs/Aesthetic-Console/blob/main/Aesthetic-Console.psm1) file [due to lack of a function to do so].

All the configuration details regarding the Output during an execution of a PowerShell cmdlet such as _Get-ChildItem_ is stored in the [Aesthetic-Console.ps1xml](https://github.com/codeadityavs/Aesthetic-Console/blob/main/Aesthetic-Console.format.ps1xml) file. It goes according to the schema mentioned in the documentation as well as the preceeding repositories.
**Thankyou hehe, this is a preliminary introduction to the project, keep reading for a more in-depth breadown of the project or just skip to the part on _How to install_**

### How to Install

First things first, it is to elaborate on _How to install_ the project. Well, this is quite and easy install. All that needs to be done is that

- Downloading the whole repository from [here](https://github.com/codeadityavs/Aesthetic-Console) to a registered module path[basically a path in which PowerShell will search for Modules to load].
- After this has been downloaded in to the correct directory, it is advised to either add the Module in to the correct session _or_ add it to the `$profile` script of the PowerShell [this is the default script any PowerShell instance will run on start up]. The following code can directly be pasted, it is
    `Import-Module -Name Aesthetic-Console`.
- Now that the module has been loaded into the PowerShell instance, there are a few global varaibles which can be accessed, them being

1. `$AestheticConsoleColors` : Is a hash table containing the  _identifier[file,folder or link name]_   and the _icon_ associated to it.
2. `$AestheticConsoleIcons` : Is a hash table containing the _identifier[file folder or link name]_     and _color_ associated to it.
3. `$PathToColorPreferences` : Is the path to _your_ custom .json file which holds a structured      format  that can be parsed to render the desired colors.
4. `$PathToIconPreferences` : Is the path to _your_ custom *.json file which holds a structured format that can be parsed to render the desired icons.

- When no customisation file has been loaded, it will point to the default file and icon paths, present in the **Default** section of the file strucutre.

This is all that is required for a basic set up. For setting up a more personalised theme, a schema has been spoken abount in the later section of the documentation as well as ways to set up and change the paths. It is more detailed in ways to change the default behaviour and hence , _should_ be read.

_NOTE_ :To see the present colors and icons, just printing the variables out will be enough. They will contain the colours. Further more, an inbuild function called the `Format-AestheticConsole` can be used with a  `ForEach-Object` pipeline. This will format and display the _identifiers_ accordingly.
