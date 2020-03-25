#escape=`

# Use the ASP.NET 4.8 base image from Microsoft
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8

# Create a directory to hold application assets
WORKDIR C:\app

# Setup IIS to run a new Site
RUN Remove-Website -Name 'Default Web Site'; ` 
  Set-ItemProperty IIS:\AppPools\DefaultAppPool `
  -Name processModel.identityType `
  -Value LocalSystem; `
  New-Website `
  -Name 'fourthcoffee' `
  -Port 80 `
  -PhysicalPath 'C:\app' `
  -ApplicationPool 'DefaultAppPool';

# Copy application assets into the container
COPY . .

# docker build --tag stevenfollis/fourthbakery:web .; docker run -it --rm --name fourthcoffee -p 3000:80 stevenfollis/fourthbakery:web