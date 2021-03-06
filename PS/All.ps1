function Invoke-BatchFile
{
   param([string]$Path, [string]$Parameters)  

   $tempFile = [IO.Path]::GetTempFileName()  

   ## Store the output of cmd.exe.  We also ask cmd.exe to output   
   ## the environment table after the batch file completes  
   cmd.exe /c " `"$Path`" $Parameters && set > `"$tempFile`" " 

   ## Go through the environment variables in the temp file.  
   ## For each of them, set the variable in our local environment.  
   Get-Content $tempFile | Foreach-Object {   
       if ($_ -match "^(.*?)=(.*)$")  
       { 
           Set-Content "env:\$($matches[1])" $matches[2]  
       } 
   }  

   Remove-Item $tempFile
}
function test-is64bitOS() {
    return [System.Environment]::Is64BitOperatingSystem
}
$WebClient = New-Object System.Net.WebClient

if ( -not (Test-Path 'C:\DelugeDownloads\vs_Community.exe' -PathType Leaf) ) { 
    Write-Host "Downloading Visual Studio 2017 Community..."
    $WebClient.DownloadFile("https://download.visualstudio.microsoft.com/download/pr/57c99182-2828-4fc1-8b36-271e2472c838/91d7b8d8ba556b1e8723ca67a0f1e2e4a8274f7dfccbeae567e78b22f0db3f6d/vs_Community.exe","C:\DelugeDownloads\vs_Community.exe")
}
if ( -not (Test-Path 'C:\DelugeDownloads\python-3.7.5-amd64.exe' -PathType Leaf) ) { 
    Write-Host "Downloading Python..."
    $WebClient.DownloadFile("https://www.python.org/ftp/python/3.7.6/python-3.7.6-amd64.exe","C:\DelugeDownloads\python-3.7.6-amd64.exe")
}
if ( -not (Test-Path 'C:\DelugeDownloads\nasm-2.14.02-win64.zip' -PathType Leaf) ) { 
    Write-Host "Downloading Nasm..."
    $WebClient.DownloadFile("https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/win64/nasm-2.14.02-win64.zip","C:\DelugeDownloads\nasm-2.14.02-win64.zip")
}
if ( -not (Test-Path 'C:\DelugeDownloads\ActivePerl-5.28.1.0000-MSWin32-x64-865dc3eb.msi' -PathType Leaf) ) { 
    Write-Host "Downloading ActivePerl..."
    $WebClient.DownloadFile("https://camel-builds.s3.amazonaws.com/ActivePerl/MSWin32-x64/20200124T180150Z/ActivePerl-5.28.1.0000-MSWin32-x64-865dc3eb.msi?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAJAFTYUXEZJ3HWLEQ%2F20200228%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200228T094216Z&X-Amz-Expires=21600&X-Amz-SignedHeaders=host&X-Amz-Signature=bfe214f134322257c4f511353ac66f94578a093a3adfc932c53b3619716ac755","C:\DelugeDownloads\ActivePerl-5.28.1.0000-MSWin32-x64-865dc3eb.msi")
}
if ( -not (Test-Path 'C:\DelugeDownloads\msys2-x86_64-20190524.exe' -PathType Leaf) ) { 
    Write-Host "Downloading Msys2..."
    $WebClient.DownloadFile("http://repo.msys2.org/distrib/x86_64/msys2-x86_64-20190524.exe","C:\DelugeDownloads\msys2-x86_64-20190524.exe")
}
if ( -not (Test-Path 'C:\DelugeDownloads\boost_1_70_0.zip' -PathType Leaf) ) { 
    Write-Host "Downloading Boost C++ Source Code..."
    $WebClient.DownloadFile("https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.zip","C:\DelugeDownloads\boost_1_70_0.zip")
}
if ( -not (Test-Path 'C:\DelugeDownloads\openssl.zip' -PathType Leaf) ) { 
    Write-Host "Downloading OpenSSL Source Code..."
    $WebClient.DownloadFile("https://github.com/openssl/openssl/archive/master.zip","C:\DelugeDownloads\openssl.zip")
}
if ( -not (Test-Path 'C:\DelugeDownloads\gvsbuild.zip' -PathType Leaf) ) { 
    Write-Host "Downloading GTK3+ gvsbuild tools..."
    $WebClient.DownloadFile("https://github.com/wingtk/gvsbuild/archive/master.zip","C:\DelugeDownloads\gvsbuild.zip")
}
if ( -not (Test-Path 'C:\DelugeDownloads\libtorrent.zip' -PathType Leaf) ) { 
    Write-Host "Downloading Libtorrent Source Code..."
    $WebClient.DownloadFile("https://github.com/arvidn/libtorrent/archive/RC_1_2.zip","C:\DelugeDownloads\libtorrent.zip")
}
if ( -not (Test-Path 'C:\DelugeDownloads\Deluge.zip' -PathType Leaf) ) { 
    Write-Host "Downloading Deluge Source Code..."
    $WebClient.DownloadFile("https://github.com/deluge-torrent/deluge/archive/develop.zip","C:\DelugeDownloads\deluge.zip")
}
if ( -not (Test-Path 'C:\DelugeDownloads\7z1900-x64.msi' -PathType Leaf) ) { 
    Write-Host "Downloading 7-zip..."
    $WebClient.DownloadFile("https://www.7-zip.org/a/7z1900-x64.msi","C:\DelugeDownloads\7z1900-x64.msi")
}

if ( -not (Test-Path 'C:\Program Files\7-Zip' -PathType Container) ) { 
    Write-Host "Installing 7-Zip..."
    Set-Location -Path 'C:\DelugeDownloads\'
    Start-Process -FilePath "C:\DelugeDownloads\7z1900-x64.msi" -ArgumentList "/quiet", "/passive", "/norestart" -Wait
}
if ( -not (Test-Path 'C:\Program Files (x86)\Microsoft Visual Studio\2017' -PathType Container) ) { 
    Write-Host "Installing Visual Studio 2017 Community..."
    Set-Location -Path 'C:\DelugeDownloads\'
    New-Item -Path "C:\DelugeDownloads\vsconfig.conf"
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '    {'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '        "version": "1.0",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '        "components": ['
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.CoreEditor",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Workload.CoreEditor",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.Roslyn.Compiler",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.Component.MSBuild",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.Static.Analysis.Tools",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.TextTemplating",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.Debugger.JustInTime",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.CoreIde",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.Redist.14.Latest",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.Graphics.Win81",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.Graphics.Tools",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.DiagnosticTools",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.Windows10SDK.17763",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.CMake.Project",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.ATL",'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Workload.NativeDesktop"'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '        ]'
    Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '      }'
    Start-Process -FilePath "C:\DelugeDownloads\vs_Community.exe" -ArgumentList "--norestart", "--quiet", "--config C:\DelugeDownloads\vsconfig.conf" -Wait
}
if ( -not (Test-Path 'C:\Program Files\Python37' -PathType Container) ) { 
    Write-Host "Installing Python..."
    Set-Location -Path 'C:\DelugeDownloads\'
    Start-Process -FilePath "C:\DelugeDownloads\python-3.7.6.exe" -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=0", "Include_test=0" -Wait
}
if ( -not (Test-Path 'C:\nasm-2.14.02' -PathType Container) ) { 
    Write-Host "Installing NASM..."
    Set-Location -Path 'C:\DelugeDownloads\'
    7z x nasm-2.14.02.zip -oc:\
}
if ( -not (Test-Path 'C:\Perl64' -PathType Container) ) { 
    Write-Host "Installing Active State Perl..."
    Set-Location -Path 'C:\DelugeDownloads\'
    Start-Process -FilePath "C:\DelugeDownloads\ActivePerl-5.28.1.0000-MSWin32-x64-865dc3eb.exe" -ArgumentList "/exenoui", "/exenoupdates" -Wait
}
if ( -not (Test-Path 'C:\msys64' -PathType Container) ) { 
    Write-Host "Installing msys..."
    Set-Location -Path 'C:\DelugeDownloads\'
}
if ( -not (Test-Path 'C:\boost_1_70_0' -PathType Container) ) { 
    Write-Host "Installing Boost C++ Source Code..."
    Set-Location -Path 'C:\DelugeDownloads\'
    New-Item -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam"
    Add-Content -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam" -Value 'using msvc : 14.1 ;'
    Add-Content -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam" -Value 'using gcc ;'
    Add-Content -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam" -Value 'using python : 3.7 : C:\\Program Files\\Python37 : C:\\Program Files\\Python37\\include : C:\\Program Files\\Python37\\libs ;'
    Invoke-BatchFile "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat"
    Invoke-BatchFile "C:\boost_1_70_0\bootstrap.bat"
    7z x boost_1_70_0.zip -oc:\
}
if ( -not (Test-Path 'C:\openssl-master' -PathType Container) ) { 
    Write-Host "Installing OpenSSL Source Code..."
    Set-Location -Path 'C:\DelugeDownloads\'
    7z x openssl.zip -oc:\
    perl configure VC-WIN64A --prefix=C:\OpenSSL-Win64
    nmake
    nmake test
    nmake install
}
if ( -not (Test-Path 'C:\gvsbuild-master' -PathType Container) ) { 
    Write-Host "Installing GTK+3 Build Tools..."
    Set-Location -Path 'C:\DelugeDownloads\'
    7z x gvsbuild.zip -oc:\
}
if ( -not (Test-Path 'C:\libtorrent-RC_1_2' -PathType Container) ) { 
    Write-Host "Installing Libtorrent Source Code..."
    Set-Location -Path 'C:\DelugeDownloads\'
    7z x libtorrent.zip -oc:\
    Set-Location -Path 'C:\libtorrent-RC_1_2\bindings\python'
    b2 libtorrent-link=static boost-link=static release toolset=msvc-14.1 optimization=space runtime-link=static link=static python=3.7 address-model=64 crypto=openssl
}
if ( -not (Test-Path 'C:\deluge-develop' -PathType Container) ) { 
    Write-Host "Installing Deluge Source Code..."
    Set-Location -Path 'C:\DelugeDownloads\'
    7z x deluge.zip -oc:\
}
$env:Path = "C:\Program Files\7-Zip;C:\Program Files\Python37;C:\boost_1_70_0;C:\nasm-2.14.02;C:\Perl64\bin;C:\msys64\bin;$env:Path"
$env:Path += ";C:\Program Files\7-Zip;C:\Program Files\Python37;C:\boost_1_70_0;C:\nasm-2.14.02;C:\Perl64\bin;C:\msys64\bin;"

Invoke-BatchFile "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat"




