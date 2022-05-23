# Aesthetic-Console

### Author : aditya vikram sinha , <adityavikramsinha19@gmail.com>

### Inspiration(s)[preceeding repositories] :
<ol>
    <li>[Terminal-Icons](https://github.com/devblackops/Terminal-Icons)</li>
    <li>[DirColors](https://github.com/DHowett/DirColors)</li>
</ol>

This project is most certainly not **original**. There are people who have done this before and in a sense, _in a better way_. However, this is not the point of this project. This project was a **personal** one to help me understand the way powershell works and also, because i was _obsessed_ with customising my powershell from the bottom up.

Most of this project works based on the *.format.ps1xml configuration given my Microsoft natively. It has been taken from the [Terminal-Icons](https://github.com/devblackops/Terminal-Icons) repository which in turn took it from [DirColors](https://github.com/DHowett/DirColors). Quite conviniently, this project has been named as **Aesthetic-Console** and uses *.json config files to catch user input. A normal user can have it located anywhere in their computer. The only important distinction is that it needs to be _for now_ manually inserted to the [Aesthetic-Console.psm1](https://github.com/codeadityavs/Aesthetic-Console/blob/main/Aesthetic-Console.psm1) file [due to lack of a function to do so].

All the configuration details regarding the Output during an execution of a PowerShell cmdlet such as _Get-ChildItem_ is stored in the [Aesthetic-Console.ps1xml](https://github.com/codeadityavs/Aesthetic-Console/blob/main/Aesthetic-Console.format.ps1xml) file. It goes according to the schema mentioned in the documentation as well as the preceeding repositories.