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
function Build64Deluge {
    if ( -not (Test-Path 'C:\DelugeDownloads\' -PathType Container) ) { 
        Write-Host "Creating Downloads Folder..."
        New-Item -ItemType Directory -Force -Path 'C:\DelugeDownloads\'
    }

    $WebClient = New-Object System.Net.WebClient
    
    if ( -not (Test-Path 'C:\DelugeDownloads\vs_Community.exe' -PathType Leaf) ) { 
        Write-Host "Downloading Visual Studio 2019 Community..."
        $WebClient.DownloadFile("https://aka.ms/vs/16/release/vs_community.exe","C:\DelugeDownloads\vs_Community.exe")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\python-3.7.9-amd64.exe' -PathType Leaf) ) { 
        Write-Host "Downloading Python..."
        $WebClient.DownloadFile("https://www.python.org/ftp/python/3.7.9/python-3.7.9-amd64.exe","C:\DelugeDownloads\python-3.7.9-amd64.exe")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\nasm-2.15.05-win64.zip' -PathType Leaf) ) { 
        Write-Host "Downloading Nasm..."
        $WebClient.DownloadFile("https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/win64/nasm-2.15.05-win64.zip","C:\DelugeDownloads\nasm-2.15.05-win64.zip")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\strawberry-perl-5.32.1.1-64bit-portable.zip' -PathType Leaf) ) { 
        Write-Host "Downloading Strawberry Perl..."
        $WebClient.DownloadFile("https://strawberryperl.com/download/5.32.1.1/strawberry-perl-5.32.1.1-64bit-portable.zip","C:\DelugeDownloads\strawberry-perl-5.32.1.1-64bit-portable.zip")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\msys2-base-x86_64-20211130.tar.xz' -PathType Leaf) ) { 
        Write-Host "Downloading Msys2..."
        $WebClient.DownloadFile("https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20211130.tar.xz","C:\DelugeDownloads\msys2-base-x86_64-20211130.tar.xz")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\boost_1_77_0.zip' -PathType Leaf) ) { 
        Write-Host "Downloading Boost C++ Source Code..."
        $WebClient.DownloadFile("https://boostorg.jfrog.io/artifactory/main/release/1.77.0/source/boost_1_77_0.zip","C:\DelugeDownloads\boost_1_77_0.zip")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\OpenSSL_1_1_1m.zip' -PathType Leaf) ) { 
        Write-Host "Downloading OpenSSL Source Code..."
        $WebClient.DownloadFile("https://github.com/openssl/openssl/archive/refs/tags/OpenSSL_1_1_1m.zip","C:\DelugeDownloads\OpenSSL_1_1_1m.zip")
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
        $WebClient.DownloadFile("https://github.com/deluge-torrent/deluge/archive/refs/tags/deluge-2.0.5.zip","C:\DelugeDownloads\deluge.zip")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\7z2106-x64.msi' -PathType Leaf) ) { 
        Write-Host "Downloading 7-zip..."
        $WebClient.DownloadFile("https://www.7-zip.org/a/7z2106-x64.msi","C:\DelugeDownloads\7z2106-x64.msi")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\Git-2.34.1-64-bit.exe' -PathType Leaf) ) { 
        Write-Host "Downloading Git..."
        $WebClient.DownloadFile("https://github.com/git-for-windows/git/releases/download/v2.34.1.windows.1/Git-2.34.1-64-bit.exe","C:\DelugeDownloads\Git-2.34.1-64-bit.exe")
    }
    if ( -not (Test-Path 'C:\Program Files\Git\cmd' -PathType Container) ) { 
        Write-Host "Installing Git..."
        Set-Location -Path 'C:\DelugeDownloads\'
        Start-Process -FilePath "C:\DelugeDownloads\Git-2.34.1-64-bit.exe" -ArgumentList "/VERYSILENT", "/SP-", "/SUPPRESSMSGBOXES", "/NORESTART", "/FORCECLOSEAPPLICATIONS" -Wait
    }
    
    if ( -not (Test-Path 'C:\Program Files\7-Zip' -PathType Container) ) { 
        Write-Host "Installing 7-Zip..."
        Set-Location -Path 'C:\DelugeDownloads\'
        Start-Process -FilePath "C:\DelugeDownloads\7z2106-x64.msi" -ArgumentList "/quiet", "/passive", "/norestart" -Wait
    }
    
    if ( -not (Test-Path 'C:\DelugeDownloads\nsis-3.08.zip' -PathType Leaf) ) { 
        Write-Host "Downloading Git..."
        $WebClient.DownloadFile("https://phoenixnap.dl.sourceforge.net/project/nsis/NSIS%203/3.08/nsis-3.08.zip","C:\DelugeDownloads\nsis-3.08.zip")
    }
    
    $env:Path = "C:\Program Files\7-Zip;$env:Path"
    $env:Path += ";C:\Program Files\7-Zip;"
    
    if ( -not (Test-Path 'C:\Program Files (x86)\Microsoft Visual Studio\2019' -PathType Container) ) { 
        Write-Host "Installing Visual Studio 2019 Community..."
        Set-Location -Path 'C:\DelugeDownloads\'
        New-Item -Path "C:\DelugeDownloads\vsconfig.conf"
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '    {'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '        "version": "1.0",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '        "components": ['
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.Component.MSBuild",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.Roslyn.Compiler",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.TextTemplating",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.CoreBuildTools",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.CoreIde",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.Redist.14.Latest",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.Windows10SDK",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.TestTools.BuildTools",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.ASAN",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.CMake.Project",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '          "Microsoft.VisualStudio.Component.Windows10SDK.19041"'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '        ]'
        Add-Content -Path "C:\DelugeDownloads\vsconfig.conf" -Value '      }'
        Start-Process -FilePath "C:\DelugeDownloads\vs_Community.exe" -ArgumentList "--norestart", "--quiet", "--config C:\DelugeDownloads\vsconfig.conf" -Wait
    }
    if ( -not (Test-Path 'C:\Python37' -PathType Container) ) { 
        Write-Host "Installing Python..."
        Set-Location -Path 'C:\DelugeDownloads\'
        Start-Process -FilePath "C:\DelugeDownloads\python-3.7.9-amd64.exe" -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=0", "Include_test=0", "TargetDir=C:\Python37" -Wait
    }
    if ( -not (Test-Path 'C:\nasm-2.15.05' -PathType Container) ) { 
        Write-Host "Installing NASM..."
        Set-Location -Path 'C:\DelugeDownloads\'
        7z x nasm-2.15.05-win64.zip -oc:\
    }
    ## if ( -not (Test-Path 'C:\Perl64' -PathType Container) ) { 
    ##     Write-Host "Installing Active State Perl..."
    ##     Set-Location -Path 'C:\DelugeDownloads\'
    ##     Start-Process -FilePath "C:\DelugeDownloads\strawberry-perl-5.32.1.1-64bit.msi" -ArgumentList "/exenoui", "/exenoupdates" -Wait
    ## }
    if ( -not (Test-Path 'C:\Perl64' -PathType Container) ) { 
        Write-Host "Installing Strawberry Perl..."
        Set-Location -Path 'C:\DelugeDownloads\'
        7z x strawberry-perl-5.32.1.1-64bit-portable.zip -oc:\Perl64\
    }
    if ( -not (Test-Path 'C:\msys64' -PathType Container) ) { 
        Write-Host "Installing msys..."
        Set-Location -Path 'C:\DelugeDownloads\'
        ## Start-Process -FilePath "C:\DelugeDownloads\msys2-x86_64-20211130.exe" -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=0", "Include_test=0" -Wait
        7z x msys2-base-x86_64-20211130.tar.xz -oc:\DelugeDownloads\
        7z x msys2-base-x86_64-20211130.tar -oc:\
    }
    if ( -not (Test-Path 'C:\boost_1_77_0' -PathType Container) ) { 
        Write-Host "Installing Boost C++ Source Code..."
        Set-Location -Path 'C:\DelugeDownloads\'
        New-Item -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam"
        Add-Content -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam" -Value 'using msvc : 15 ;'
        Add-Content -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam" -Value 'using python : 3.7 : C:\\Python37 : C:\\Python37\\include : C:\\Python37\\libs ;'
        7z x boost_1_77_0.zip -oc:\
    }
    if ( -not (Test-Path 'C:\openssl-OpenSSL_1_1_1m' -PathType Container) ) { 
        Write-Host "Installing OpenSSL Source Code..."
        Set-Location -Path 'C:\DelugeDownloads\'
        7z x OpenSSL_1_1_1m.zip -oc:\
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
    }
    if ( -not (Test-Path 'C:\deluge-develop' -PathType Container) ) { 
        Write-Host "Installing Deluge Source Code..."
        Set-Location -Path 'C:\DelugeDownloads\'
        7z x deluge.zip -oc:\
    }
    
    if ( -not (Test-Path 'C:\nsis-3.08' -PathType Container) ) { 
        Write-Host "Installing NASM..."
        Set-Location -Path 'C:\DelugeDownloads\'
        7z x nsis-3.08.zip -oc:\
    }

    $env:Path = "C:\Program Files\Git\bin;C:\Program Files\7-Zip;C:\Python37;C:\Python37\Scripts;C:\boost_1_77_0;C:\nasm-2.15.05;C:\Perl64\perl\bin;C:\msys64\usr\bin;$env:Path"
    $env:Path += ";C:\Program Files\Git\bin;C:\Program Files\7-Zip;C:\Python37;C:\Python37\Scripts;C:\boost_1_77_0;C:\nasm-2.15.05;C:\Perl64\perl\bin;C:\msys64\usr\bin;"
    $env:BOOST_ROOT="c:\boost_1_77_0"
    $env:BOOST_BUILD_PATH="c:\boost_1_77_0\tools\build"
    Invoke-BatchFile "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2019\Community\VC\Auxiliary\build\vcvars64.bat"
    
    Write-Host "Compileing OpenSSL..."
    Set-Location -Path 'C:\openssl-OpenSSL_1_1_1m\'
    perl configure VC-WIN64A --prefix=C:\OpenSSL-Win64
    nmake
    ## nmake test
    nmake install
    
    Write-Host "Prepareing Boost C++..."
    Set-Location -Path 'C:\boost_1_77_0\'
    Invoke-BatchFile "C:\boost_1_77_0\bootstrap.bat"
    b2
    
    Write-Host "Compileing Lbitorrent For Python..."
    Set-Location -Path 'C:\libtorrent-RC_1_2\bindings\python'
    #b2 --hash libtorrent-link=static boost-link=static release toolset=msvc-15 optimization=space runtime-link=static link=static python=3.7 address-model=64 crypto=openssl openssl-include=C:\OpenSSL-Win64\include openssl-lib=C:\OpenSSL-Win64\lib
    b2 --hash libtorrent-link=static boost-link=static release toolset=msvc-15 optimization=space runtime-link=static link=static python=3.7 address-model=64 crypto=openssl openssl-include=C:\OpenSSL-Win64\include openssl-lib=C:\OpenSSL-Win64\lib
    
    Write-Host "Updating Pip..."
    python -m pip install --upgrade pip

    Write-Host "Compileing GTK+3 For Python..."
    Set-Location -Path 'C:\gvsbuild-master'
    pip install wheel
    ## python .\build.py build -p=x64 --same-python --vs-ver=15 --msys-dir=C:\msys64 --gtk3-ver=3.24 gtk3
    python build.py -d build --clean --gtk3-ver=3.24 --vs-ver=16 --platform=x64 --same-python -k --enable-gi --py-wheel enchant gtk3-full pycairo pygobject lz4 --skip gtksourceview,emeus,clutter --capture-out --print-out
    ## python build.py -d build --clean --gtk3-ver=3.24 --vs-ver=15 --platform=x64 --same-python -k --enable-gi --py-wheel --py-egg enchant gtk gtk3-full pycairo pygobject lz4
    
    $env:Path = "C:\gtk-build\gtk\x64\release\bin;C:\Program Files\Git\bin;C:\Program Files\7-Zip;C:\Python37;C:\Python37\Scripts;C:\boost_1_77_0;C:\nasm-2.15.05;C:\Perl64\perl\bin;C:\msys64\usr\bin;$env:Path"
    $env:Path += ";C:\gtk-build\gtk\x64\release\bin;C:\Program Files\Git\bin;C:\Program Files\7-Zip;C:\Python37;C:\Python37\Scripts;C:\boost_1_77_0;C:\nasm-2.15.05;C:\Perl64\perl\bin;C:\msys64\usr\bin;"
    
    Write-Host "Compileing\Installing Deluge..."
    Set-Location -Path 'C:\deluge-deluge-2.0.5\'
    New-Item -Path "C:\deluge-deluge-2.0.5\RELEASE-VERSION"
    Add-Content -Path "C:\deluge-deluge-2.0.5\RELEASE-VERSION" -Value '2.0.5'
    python -m pip install -r requirements.txt
    python setup.py clean
    python setup.py build
    python setup.py install
    
    Write-Host "Installing PyInstaller..."
    pip install pyinstaller
    
    Write-Host "Downloading Spec File For Deluge PyInstaller..."
    $WebClient.DownloadFile("https://github.com/doadin/DelugeBuildFromSource/raw/master/deluge.spec","C:\deluge-develop\deluge.spec")
    pyinstaller --clean deluge.spec
    
}

function Build32Deluge {
    $WebClient = New-Object System.Net.WebClient
    
    if ( -not (Test-Path 'C:\DelugeDownloads\vs_Community.exe' -PathType Leaf) ) { 
        Write-Host "Downloading Visual Studio 2017 Community..."
        $WebClient.DownloadFile("https://download.visualstudio.microsoft.com/download/pr/57c99182-2828-4fc1-8b36-271e2472c838/91d7b8d8ba556b1e8723ca67a0f1e2e4a8274f7dfccbeae567e78b22f0db3f6d/vs_Community.exe","C:\DelugeDownloads\vs_Community.exe")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\python-3.7.9.exe' -PathType Leaf) ) { 
        Write-Host "Downloading Python..."
        $WebClient.DownloadFile("https://www.python.org/ftp/python/3.7.9/python-3.7.9.exe","C:\DelugeDownloads\python-3.7.9.exe")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\nasm-2.15-win32.zip' -PathType Leaf) ) { 
        Write-Host "Downloading Nasm..."
        $WebClient.DownloadFile("https://www.nasm.us/pub/nasm/releasebuilds/2.15/win32/nasm-2.15-win32.zip","C:\DelugeDownloads\nasm-2.15-win32.zip")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\strawberry-perl-5.32.1.1-32bit-portable.zip' -PathType Leaf) ) { 
        Write-Host "Downloading ActivePerl..."
        $WebClient.DownloadFile("https://strawberryperl.com/download/5.32.1.1/strawberry-perl-5.32.1.1-32bit-portable.zip","C:\DelugeDownloads\strawberry-perl-5.32.1.1-32bit-portable.zip")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\msys2-i686-20200517.exe' -PathType Leaf) ) { 
        Write-Host "Downloading Msys2..."
        $WebClient.DownloadFile("http://repo.msys2.org/distrib/i686/msys2-i686-20200517.exe","C:\DelugeDownloads\msys2-i686-20200517.exe")
    }
    if ( -not (Test-Path 'C:\DelugeDownloads\boost_1_77_0.zip' -PathType Leaf) ) { 
        Write-Host "Downloading Boost C++ Source Code..."
        $WebClient.DownloadFile("https://boostorg.jfrog.io/artifactory/main/release/1.77.0/source/boost_1_77_0.zip","C:\DelugeDownloads\boost_1_77_0.zip")
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
    if ( -not (Test-Path 'C:\nasm-2.15' -PathType Container) ) { 
        Write-Host "Installing NASM..."
        Set-Location -Path 'C:\DelugeDownloads\'
        7z x nasm-2.14.02.zip -oc:\
    }
    ## if ( -not (Test-Path 'C:\Perl64' -PathType Container) ) { 
    ##     Write-Host "Installing Active State Perl..."
    ##     Set-Location -Path 'C:\DelugeDownloads\'
    ##     Start-Process -FilePath "C:\DelugeDownloads\strawberry-perl-5.32.1.1-64bit.msi" -ArgumentList "/exenoui", "/exenoupdates" -Wait
    ## }
    if ( -not (Test-Path 'C:\Perl' -PathType Container) ) { 
        Write-Host "Installing Strawberry Perl..."
        Set-Location -Path 'C:\DelugeDownloads\'
        7z x strawberry-perl-5.32.1.1-32bit-portable.zip -oc:\Perl\
    }
    if ( -not (Test-Path 'C:\msys64' -PathType Container) ) { 
        Write-Host "Installing msys..."
        Set-Location -Path 'C:\DelugeDownloads\'
    }
    if ( -not (Test-Path 'C:\boost_1_77_0' -PathType Container) ) { 
        Write-Host "Installing Boost C++ Source Code..."
        Set-Location -Path 'C:\DelugeDownloads\'
        New-Item -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam"
        Add-Content -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam" -Value 'using msvc : 14.1 ;'
        Add-Content -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam" -Value 'using gcc ;'
        Add-Content -Path "$env:HOMEDRIVE\$env:HOMEPATH\user-config.jam" -Value 'using python : 3.7 : C:\\Program Files\\Python37 : C:\\Program Files\\Python37\\include : C:\\Program Files\\Python37\\libs ;'
        7z x boost_1_77_0.zip -oc:\
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
        Invoke-BatchFile "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat"
        b2 libtorrent-link=static boost-link=static release toolset=msvc-14.1 optimization=space runtime-link=static link=static python=3.7 address-model=32 crypto=openssl
    }
    if ( -not (Test-Path 'C:\deluge-develop' -PathType Container) ) { 
        Write-Host "Installing Deluge Source Code..."
        Set-Location -Path 'C:\DelugeDownloads\'
        7z x deluge.zip -oc:\
    }
    $env:Path = "C:\Program Files\7-Zip;C:\Program Files\Python37;C:\boost_1_77_0;C:\nasm-2.15;C:\Perl\bin;C:\msys64\bin;$env:Path"
    $env:Path += ";C:\Program Files\7-Zip;C:\Program Files\Python37;C:\boost_1_77_0;C:\nasm-2.15;C:\Perl\bin;C:\msys64\bin;"
    
    Invoke-BatchFile "${env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\Community\Common7\Tools\VsDevCmd.bat"
    Set-Location -Path 'C:\deluge-develop\'
    python setup.py build
    python setup.py install
}

if (test-is64bitOS) {
    Build64Deluge
}

if ( -not (test-is64bitOS)) {
    ## Build32Deluge
    Write-Host "32 Bit Build Setup Not Yet Supported..."
}

