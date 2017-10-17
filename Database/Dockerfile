# escape=`

# ================
# Builder Image
# ================
# Downloads dependencies and compiles the SQL Project
FROM microsoft/windowsservercore:10.0.14393.1715 AS builder
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# Install Chocolatey for headless installation of MSFT Build tooling
RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force; `
    Install-Package -Name microsoft-build-tools -RequiredVersion 15.0.26228.0 -Force; `
    Install-Package -Name netfx-4.6.2-devpack -RequiredVersion 4.6.01590.20170129 -Force

# Install Nuget and install Microsoft Data Tools
RUN Install-Package nuget.commandline -RequiredVersion 3.5.0 -Force; `
    & C:\Chocolatey\bin\nuget install Microsoft.Data.Tools.Msbuild -Version 10.0.61708.210

# Add MSBuild to Path for easier usage
ENV MSBUILD_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin"
RUN $env:PATH = $env:MSBUILD_PATH + ';' + $env:PATH; `
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

# Create a folder in the image and copy over VS Project files
WORKDIR C:\src
COPY . .

# Build project
RUN msbuild Database.sqlproj `
      /p:SQLDBExtensionsRefPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61708.210\lib\net46" `
      /p:SqlServerRedistPath="C:\Microsoft.Data.Tools.Msbuild.10.0.61708.210\lib\net46" `
	  /p:Configuration=Release

# ================
# Database Image
# ================
FROM microsoft/mssql-server-windows-express:2017-windowsservercore-10.0.14393.1715
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force; `
	Install-Package nuget.commandline -RequiredVersion 3.5.0 -Force; `
    & C:\Chocolatey\bin\nuget install Microsoft.Data.Tools.Msbuild -Version 10.0.61708.210; `
	mkdir C:\database

# Copy built dacpac (from earlier build stage) and configuration scripts
WORKDIR C:\init
COPY --from=builder C:\src\bin\Release\Database.dacpac .
COPY Initialize-Database.ps1 .
COPY SampleData.sql .

# Set startup command to initalize the database
CMD ./Initialize-Database.ps1 -sa_password $env:sa_password -Verbose