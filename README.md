# Aesthetic Console
This module helps to add **icons** , **styles** and **colors** to outputs from common cmdlets like _Get-ChildItem_ , _Get-Item_ and formatters like _Format-Table_ and   _Format-Wide_

Below are a few screenshots illustrating what kind of output this can render :
1. _When piping the output of a function into a pipeline_
2. _When using Get-ChildItem [or any of its aliases]_

## Prerequisites
- PowerShell 6.0 or higher is required (Preferably from the Microsoft store or some other place which can guarantee security)
- A [nerd font](https://www.nerdfonts.com/) supporting glyphs is required for the icons
- [Execution policy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.2) of PowerShell needs to be set to **Bypass** either for the current user or the process

## Installation
The installation is fairly simple for the module.
1. Download the zip folder from [this](https://github.com/codeadityavs/Aesthetic-Console/tree/install) in to any directory you wish. **The zip folder name will be Aesthetic-Console-install.zip**, it should be modified to **Aesthetic-Console.zip**.
2. Then, extract the downloaded zip (Aesthetic-Console.zip) from the folder the zip file was just downloaded in to the folder which holds _all_ your modules
_Note_ : If you are unsure of what is the path[s] which PowerShell looks at when looking for modules, try using this command in PowerShell :
```$env:PSModulePath.Split(";")``` to get the paths.
3. After the zip file has been extracted to any a path of choice, type this command ```Import-Module -Name Aesthetic-Console```. What this does is that it tells the current instance to Import a module which _may_ be present in one of the search paths[if the module has been installed correctly].
4. If all is well then, there will be no red squiggly lines or errors. Proceed to copy and paste this command ```Install-AestheticConsole```. If the install has been done then there will be a success message on the screen in **green**.
5. Great, now it is possible to use the module in the given shell instance. However, to be able to **see** the output, ```Set-Information`` will have to be run (you can just paste it as is).
6. If after this, no error have been found then it is best to run a cmdlet like _Get-ChildItem_ to see the output it renders. **Alternatively** , one could run the _Get-ChildItem_ cmdlet and pipe it into the ```Format-AestheticConsole``` formatter. Simply pasting this line will do :
```Get-ChildItem | Format-AestheticConsole```.
7. If everything is working properly then your output should be somewhat like the screenshots attached in the heading of this guide. If not then either you can raise an issue or contact me personally at adityavikramsinha19@gmail.com so that this can be fixed.
_Note_: Giving a detailed log of the errors that popped up or any screenshots that clearly show the issues is always better than just writing what _might_ have gone wrong.
8. Finally, if you would like this to be available for **all** PowerShell instances, first type ```notepad $profile``` in an instance and then add ```Import-Module -Name Aesthetic-Console``` to any line there. This ensures that everytime PowerShell reboots with a new instance, the module is by default included in to the active modules section.
