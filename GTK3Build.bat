REM VS 2015 C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin
REM Python 3.7 x64 C:\Python\Python37
REM MSVC Versions https://en.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B
REM VS 2019 Tooset Paths C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC

REM MSVC 2017 C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64
REM MSVC 2019 C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.21.27702\bin\Hostx64\x64

REM MSVC++ 9.0   _MSC_VER == 1500 (Visual Studio 2008 version 9.0)
REM MSVC++ 10.0  _MSC_VER == 1600 (Visual Studio 2010 version 10.0)
REM MSVC++ 11.0  _MSC_VER == 1700 (Visual Studio 2012 version 11.0)
REM MSVC++ 12.0  _MSC_VER == 1800 (Visual Studio 2013 version 12.0)
REM MSVC++ 14.0  _MSC_VER == 1900 (Visual Studio 2015 version 14.0)
REM MSVC++ 14.1  _MSC_VER == 1910 (Visual Studio 2017 version 15.0)
REM MSVC++ 14.11 _MSC_VER == 1911 (Visual Studio 2017 version 15.3)
REM MSVC++ 14.12 _MSC_VER == 1912 (Visual Studio 2017 version 15.5)
REM MSVC++ 14.13 _MSC_VER == 1913 (Visual Studio 2017 version 15.6)
REM MSVC++ 14.14 _MSC_VER == 1914 (Visual Studio 2017 version 15.7)
REM MSVC++ 14.15 _MSC_VER == 1915 (Visual Studio 2017 version 15.8)
REM MSVC++ 14.16 _MSC_VER == 1916 (Visual Studio 2017 version 15.9)
REM MSVC++ 14.2  _MSC_VER == 1920 (Visual Studio 2019 Version 16.0)
REM MSVC++ 14.21 _MSC_VER == 1921 (Visual Studio 2019 Version 16.1)

REM %PYTHON% build.py build --archives-download-dir=%DOWNLOAD_DIR% --platform=%PLATFORM% --vs-ver=%VS_VER% -k --fast-build --clean-built --py-wheel --py-egg --python-ver 3.6 pycairo pygobject
REM %PYTHON% build.py build --archives-download-dir=%DOWNLOAD_DIR% --platform=%PLATFORM% --vs-ver=%VS_VER% -k --fast-build --clean-built --py-wheel --py-egg --python-ver 3.5 pycairo pygobject

set DOWNLOAD_DIR=C:\builds\gtk3build\DOWNLOADS
set PYTHONVER=37
set PYTHONPATH=C:\Python\Python37
REM set VSPATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64
REM set VSPATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64
set MSYSPATH=C:\msys64\usr\bin
set PATH=%PYTHONPATH%;%MSYSPATH%;%PATH%
set platform=x64
set VS_VER=15
set VS_VCVARS=14.16
set arch=amd64
set VSCMD_DEBUG=1
REM cd "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools"
REM call VsDevCmd.bat -arch=%arch% -host_arch=%arch% -vcvars_ver=%VS_VCVARS%
cd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build"
call vcvars64.bat
REM cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC"
REM call vcvarsall.bat amd64
cd C:\gtk-build\github\gvsbuild-master
REM %PYTHON% build.py build --archives-download-dir=%DOWNLOAD_DIR% --platform=x64 --vs-ver=%VS_VER% --python-dir=C:\Python\Python37 -k --enable-gi --py-wheel --py-egg --python-ver 3.7 enchant gtk gtk3-full pycairo pygobject lz4
%PYTHON% build.py build --clean --check-hash --gtk3-ver=3.24 --archives-download-dir=%DOWNLOAD_DIR% --vs-ver=%VS_VER% --platform=x64 --vs-install-path "c:\Program Files (x86)\Microsoft Visual Studio\2017\Community" --python-dir=C:\Python\Python37 -k --enable-gi --py-wheel --py-egg --python-ver 3.7 enchant gtk gtk3-full pycairo pygobject lz4
IF "%PLATFORM%"=="x86" tar.exe -zcf gvsbuild-vs%VS_VER%-%PLATFORM%-%PYTHONVER%.tar.gz -C c:/gtk-build/gtk/Win32 release
IF "%PLATFORM%"=="x64" tar.exe -zcf gvsbuild-vs%VS_VER%-%PLATFORM%-%PYTHONVER%.tar.gz -C c:/gtk-build/gtk/x64 release
