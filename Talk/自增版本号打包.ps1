$LibraryName = "Talk"
[xml]$versionXml = Get-Content ./version.props
$Version = $versionXml.Project.PropertyGroup.VersionPrefix.split("\.")
$Version[3] = ($version[3] -as [int]) + 1 
$Version = $Version -join "."
$versionXml.Project.PropertyGroup.VersionPrefix = $Version
$versionSuffix = $versionXml.Project.PropertyGroup.VersionSuffix
$versionXml.Save("$PSScriptRoot/version.props")

Write-Host '����������...'
dotnet add package Talk.Extensions

# ���
Write-Host '��ʼ���...'
dotnet pack /p:Version=$Version$versionSuffix -c Release

Write-Host '��ʼ�ϴ�...'
nuget push ./bin/Release/$LibraryName.$Version$versionSuffix.nupkg -ApiKey oy2irwyzh6oprjroljwav5aospph6tuepbjibnvdcwmhq4 -Source https://api.nuget.org/v3/index.json

Write-Host '����ո��˳�...' -NoNewline
$null = [Console]::ReadKey('?') #�ȴ����밴��