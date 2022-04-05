@echo off

SET DIR=%~dp0%

::download install.ps1
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://community.chocolatey.org/install.ps1','%DIR%install.ps1'))"
::run installer
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%DIR%install.ps1' %*"

choco install adobereader --version 2022.001.20085 -y
choco install googlechrome --version 100.0.4896.60 -y
choco install jre8 --version 8.0.321 -y
choco install google-drive-file-stream --version 55.0.3.0 -y
choco install slack --version 4.25.0 -y
choco install notion --version 2.0.23 -y
choco install zoom --version 5.10.1.4420 -y
choco install office365business --version 14729.20228 -y
choco install adobe-creative-cloud --version 5.3.5.13 -y
