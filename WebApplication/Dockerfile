FROM microsoft/aspnet:4.7
ARG source
WORKDIR /web-app
RUN Remove-Website -Name 'Default Web Site'; \ 
    Set-ItemProperty IIS:\AppPools\DefaultAppPool -Name processModel.identityType -Value LocalSystem; \
    New-Website -Name 'web-app' -Port 80 -PhysicalPath 'C:\web-app' -ApplicationPool 'DefaultAppPool'
COPY ${source:-obj/Docker/publish} .