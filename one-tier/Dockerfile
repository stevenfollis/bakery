#escape=`

# docker build --tag foo/bakery:web .; 
# docker run -it --rm --name bakery -p 3000:80 foo/bakery:web

# Use the ASP.NET 4.8 base image from Microsoft
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

# Create a directory to hold application assets
WORKDIR C:\app

# Configure the IIS App Pool Identity
RUN Import-Module WebAdministration; `
  Set-ItemProperty IIS:\AppPools\DefaultAppPool `
  -Name processModel.identityType `
  -Value LocalSystem;

# Remove default IIS site
RUN Remove-Website -Name 'Default Web Site';

# Create new IIS site
RUN New-Website `
  -Name 'bakery' `
  -Port 80 `
  -PhysicalPath 'C:\app' `
  -ApplicationPool 'DefaultAppPool';

# Copy application assets into the container
COPY . .