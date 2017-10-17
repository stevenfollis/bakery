# Adapted from Microsoft's SQL Server Express sample:
# https://github.com/Microsoft/sql-server-samples/blob/master/samples/manage/windows-containers/mssql-server-2016-express-windows/start.ps1
# And Docker Labs' SQL Server Lab
# https://github.com/docker/labs/tree/master/windows/sql-server

param(
    [Parameter(Mandatory=$false)]
    [string]$sa_password)

# Start the service
Write-Verbose 'Starting SQL Server'
Start-Service MSSQL`$SQLEXPRESS

if ($sa_password -ne "_") {
	Write-Verbose 'Changing SA login credentials'
    $sqlcmd = "ALTER LOGIN sa with password='$sa_password'; ALTER LOGIN sa ENABLE;"
    Invoke-Sqlcmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS" 
}

# Attach data files if they exist: 
$mdfPath = 'c:\database\BakeryDB_Primary.mdf'
if ((Test-Path $mdfPath) -eq $true) {
    $sqlcmd = "CREATE DATABASE BakeryDB ON (FILENAME = N'$mdfPath')"
    $ldfPath = 'c:\database\BakeryDB_Primary.ldf'
    if ((Test-Path $mdfPath) -eq $true) {
        $sqlcmd =  "$sqlcmd, (FILENAME = N'$ldfPath')"
    }
    $sqlcmd = "$sqlcmd FOR ATTACH;"
    Write-Verbose "Invoke-Sqlcmd -Query $($sqlcmd) -ServerInstance '.\SQLEXPRESS'"
    Invoke-Sqlcmd -Query $sqlcmd -ServerInstance ".\SQLEXPRESS"
}

# Deploy or upgrade the database:
$SqlPackagePath = 'C:\Microsoft.Data.Tools.Msbuild.10.0.61708.210\lib\net46\SqlPackage.exe'
& $SqlPackagePath  `
    /sf:Database.dacpac `
    /a:Script `
	/op:create.sql `
	/p:CommentOutSetVarDeclarations=true `
    /tsn:.\SQLEXPRESS `
	/tdn:BakeryDB `
	/tu:sa `
	/tp:$sa_password 

$SqlCmdVars = "DatabaseName=BakeryDB", "DefaultFilePrefix=BakeryDB", "DefaultDataPath=c:\database\", "DefaultLogPath=c:\database\"  
Invoke-Sqlcmd -InputFile create.sql -Variable $SqlCmdVars -Verbose
Write-Verbose "Deployed dacpac"

# Insert sample data
Write-Verbose "Inserting Sample Data"
Invoke-Sqlcmd -InputFile .\SampleData.sql -ServerInstance .\SQLEXPRESS

# Relay SQL event logs to Docker
$lastCheck = (Get-Date).AddSeconds(-2) 
while ($true) { 
    Get-EventLog -LogName Application -Source "MSSQL*" -After $lastCheck | Select-Object TimeGenerated, EntryType, Message	 
    $lastCheck = Get-Date 
    Start-Sleep -Seconds 2 
}