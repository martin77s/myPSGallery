
## Register the NuGetProvider
```powershell
$nugetProvider = Get-Item .\NuGet\Microsoft.PackageManagement.NuGetProvider.dll
$targetFolder =  ('{0}\PackageManagement\ProviderAssemblies\nuget\{1}'-f $env:ProgramFiles, $nugetProvider.VersionInfo.FileVersion)
New-Item -Path $targetFolder -ItemType Directory -Force | Out-Null
Copy-Item -Path $nugetProvider -Destination $targetFolder
```


## Register NuGet.exe
```powershell
Copy-Item -Path .\NuGet\nuget.exe -Destination $env:ProgramData\Microsoft\Windows\PowerShell\PowerShellGet
```