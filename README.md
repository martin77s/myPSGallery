# myPSGallery
POC for a Private PowerShell Gallery


## Register the repository
```powershell
$uri = 'http://localhost:8080/nuget'
$repo = @{
    Name = 'MyRepository'
    SourceLocation = $uri
    PublishLocation = $uri
    InstallationPolicy = 'Trusted'
}
Register-PSRepository @repo
```



## Verify the repository
```powershell
Get-PSRepository
```


## Publish a module
```powershell
$apiKey = '01234567-89ab-cdef-0123-456789abcdef'
Publish-Module -Name Revoke-Obfuscation -Repository myRepository -NuGetApiKey $apiKey -Verbose -Tags Security
```


## Verify the module is in the repository
```powershell
Find-Module -Repository myRepository
```
