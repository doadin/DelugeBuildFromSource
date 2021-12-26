if ( -not (Test-Path 'C:\DelugeBuildFromSource\' -PathType Container) ) { 
    Write-Host "Creating DelugeBuildFromSource Folder..."
    New-Item -ItemType Directory -Force -Path 'C:\DelugeBuildFromSource\'
}
if (Test-Path 'C:\DelugeBuildFromSource\All.ps1' -PathType Leaf) { 
    Write-Host "Updating All Powershell Script..."
    Remove-Item -Path 'C:\DelugeBuildFromSource\All.ps1' -Force
    $WebClient.DownloadFile("https://github.com/doadin/DelugeBuildFromSource/raw/master/PS/All.ps1","C:\DelugeBuildFromSource\All.ps1")
else
    Write-Host "Downloading All Powershell Script..."
    $WebClient.DownloadFile("https://github.com/doadin/DelugeBuildFromSource/raw/master/PS/All.ps1","C:\DelugeBuildFromSource\All.ps1")
}
