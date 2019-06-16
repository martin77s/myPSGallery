<%@ Page Language="C#" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="NuGet.Server" %>
<%@ Import Namespace="NuGet.Server.App_Start" %>
<%@ Import Namespace="NuGet.Server.Infrastructure" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Private Repository</title>
    <style type="text/css">
		body { font-family: Calibri; }
		code { font-family: monospace; font-size: 14px;}
		a:link { color: yellow; }
		a:visited { color: yellow; }
		a:hover { color: aqua; }
		a:active { color: red; }
		fieldset { 
			font-family: sans-serif;
			font-size: 14px;
			color:#ffffff;
			border: 2px solid #ffffff;
			background: #000080;
			padding: 0px 20px;
		}
		fieldset legend {
			font-size: 14px;
			background: #ffffff;
			color: #000000;
			padding: 10px 5px;
			width: 580px;
			border-radius: 5px;
			box-shadow: 0 0 0 5px #000080;
		}
	</style>
	<script>
		function CopyCode (elm) {
			var str = document.getElementById(elm).innerText;
			var el = document.createElement('textarea');
			el.value = str;
			el.setAttribute('readonly', '');
			el.style = {position: 'absolute', left: '-9999px'};
			document.body.appendChild(el);
			el.select();
			document.execCommand('copy');
			document.body.removeChild(el);
		}
	</script>
</head>
<body>
    <div>
        <h2>Private Repository - NuGet.Server v<%= typeof(NuGetODataConfig).Assembly.GetName().Version %></h2>

        <fieldset>
			<legend>&nbsp;&nbsp;<a href=# onclick="CopyCode('RegisterRepositoryCode');"><img src="images/clip.svg" height=24 width=24></a>
				<strong>Use the commands below to register this repository in your profile:&nbsp;&nbsp;</strong></legend>
            <blockquote id='RegisterRepositoryCode'><code>
				$uri = 'https://<%= Dns.GetHostEntry("localhost").HostName.ToString() %>'<br />
				Invoke-WebRequest -Uri "$uri/packages/PackageManagement_1.3.1.zip" -Method Get -OutFile $home\downloads\PackageManagement_1.3.1.zip<br />
				Invoke-WebRequest -Uri "$uri/packages/PowerShellGet_2.0.4.zip" -Method Get -OutFile $home\downloads\PowerShellGet_2.0.4.zip<br />
				Expand-Archive -Path $home\downloads\PackageManagement_1.3.1.zip -DestinationPath 'C:\Program Files\WindowsPowerShell\Modules\PackageManagement' -Force <br />
				Expand-Archive -Path $home\downloads\PowerShellGet_2.0.4.zip -DestinationPath 'C:\Program Files\WindowsPowerShell\Modules\PowerShellGet' -Force<br />
				Get-PSRepository | Unregister-PSRepository<br />
				Register-PSRepository -Name PSRepository -SourceLocation "$uri/nuget" -PublishLocation "$uri/nuget" -InstallationPolicy Trusted
            </code></blockquote>
        </fieldset>
        <br /><br />
		
        <fieldset>
			<legend>&nbsp;&nbsp;<a href=# onclick="CopyCode('FindModulesCode');"><img src="images/clip.svg" height=24 width=24></a>
				<strong>Use the command below to find modules in the repository:&nbsp;&nbsp;</strong></legend>
            <blockquote id='FindModulesCode'><code>
                Find-Module
            </code></blockquote>
        </fieldset>
        <br /><br />
		
        <fieldset>
			<legend>&nbsp;&nbsp;<a href=# onclick="CopyCode('PublishModulesCode');"><img src="images/clip.svg" height=24 width=24></a>
				<strong>Use the command below to publish modules to this feed:&nbsp;&nbsp;</strong></legend>
            <blockquote id='PublishModulesCode'><code>
<!--                nuget.exe push {package file} {apikey} -Source <%= Helpers.GetPushUrl(Request.Url, Request.ApplicationPath) %> -->
                Publish-Module -Repository PSRepository -Name $ModuleName -NuGetApiKey '01234567-89ab-cdef-0123-456789abcdef'
            </code></blockquote>
        </fieldset>
        <br /><br />

		<fieldset>
			<legend><strong>&nbsp;&nbsp;View packages&nbsp;&nbsp;</strong></legend>
			<blockquote>
				Click <a href="<%= VirtualPathUtility.ToAbsolute("~/nuget/Packages") %>">here</a> to view your published modules
			<blockquote/>
        </fieldset>

        <br /><br />
        <% if (Request.IsLocal) { %>
        <fieldset>
            <legend><strong>&nbsp;&nbsp;Adding packages&nbsp;&nbsp;</strong></legend>
			<blockquote>
				To add packages to the feed put package files (.nupkg files) in the folder
				<code><% = PackageUtility.PackagePhysicalPath %></code><br/><br/>
				Click <a href="<%= VirtualPathUtility.ToAbsolute("~/nuget/clear-cache") %>">here</a> to clear the package cache.
			<blockquote/>
        </fieldset>
        <% } %>
    </div>
</body>
</html>
