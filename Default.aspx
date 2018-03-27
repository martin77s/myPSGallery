<%@ Page Language="C#" %>
<%@ Import Namespace="NuGet.Server" %>
<%@ Import Namespace="NuGet.Server.App_Start" %>
<%@ Import Namespace="NuGet.Server.Infrastructure" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>myPSGallery: Private PowerShell Repository</title>
    <style type="text/css"> 
	body { font-family: Calibri; } 
	code { font-family: monospace; font-size: 16px }
    </style>
</head>
<body>
    <div>
        <h2>myPSGallery: Private PowerShell Repository (NuGet.Server v<%= typeof(NuGetODataConfig).Assembly.GetName().Version %>)</h2>
        <fieldset>
            <legend><strong>[ View published modules, scripts and packages ]</strong></legend><br/>
            Click <a href="<%= VirtualPathUtility.ToAbsolute("~/nuget/Packages") %>">here</a> to view your published modules<br/><br/>
        </fieldset>
        <br />
        <fieldset>
            <legend><strong>[ Register the repository ]</strong></legend><br/>
            Use the <strong>PowerShell</strong> commands below to register this repository in your profile:
            <blockquote>
                <code>
$uri = '<%= Helpers.GetRepositoryUrl(Request.Url, Request.ApplicationPath) %>'</code><br />
                <code>
Register-PSRepository -Name myPSGallery -SourceLocation $uri
 -PublishLocation $uri -InstallationPolicy Trusted</code>
            </blockquote>
        </fieldset>
        <br />
        <fieldset>
            <legend><strong>[ Publish to the repository ]</strong></legend><br/>
            Use the <strong>PowerShell</strong> commands below to publish modules to this feed:
            <blockquote>
                <code>$moduleName = 'myModuleName'</code><br />
                <code>$apiKey = '01234567-89ab-cdef-0123-456789abcdef'</code><br />
                <code>Publish-Module -Repository myPSGallery -Name $moduleName -NuGetApiKey $apiKey</code>
            </blockquote>
            Or use the <strong>nuget.exe</strong> command below to publish nuget packages to this feed:
            <blockquote>
                <code>nuget.exe push {package file} {apikey} -Source <%= Helpers.GetPushUrl(Request.Url, Request.ApplicationPath) %></code>
            </blockquote>
        </fieldset>
        <br />
        <% if (Request.IsLocal) { %>
        <fieldset>
            <legend><strong>[ Adding packages locally ]</strong></legend><br/>
            To locally add packages to the feed put the package files (.nupkg files) under 
            <code><% = PackageUtility.PackagePhysicalPath %></code><br/><br/>
        </fieldset>
        <br />
        <fieldset>
            <legend><strong>[ Clear the package cache ]</strong></legend><br/>
            Click <a href="<%= VirtualPathUtility.ToAbsolute("~/nuget/clear-cache") %>">here</a> to clear the package cache.<br/><br/>
        </fieldset>
        <% } %>
    </div>
</body>
</html>
