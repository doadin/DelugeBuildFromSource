ECHO OFF
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
ECHO ON
ECHO Setting DOWNLOAD_DIR Variable.....
set DOWNLOAD_DIR=C:\builds\gtk3build\DOWNLOADS
if NOT ["%errorlevel%"]==["0"] pause
ECHO Setting PYTHONVER Variable.....
set PYTHONVER=37
if NOT ["%errorlevel%"]==["0"] pause
ECHO Setting PYTHONPATH Variable.....
if NOT exist "C:\Python\Python37" echo python not found
set PYTHONPATH=C:\Python\Python37
if NOT ["%errorlevel%"]==["0"] pause
ECHO OFF
REM set VSPATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64
REM set VSPATH=C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64
ECHO ON
ECHO Setting MSYSPATH Variable.....
set MSYSPATH=C:\msys64\usr\bin
if NOT exist "C:\msys64\usr\bin" echo msys not found
if NOT ["%errorlevel%"]==["0"] pause
ECHO Setting PATH Variable.....
set PATH=%PYTHONPATH%;%MSYSPATH%;%PATH%
if NOT ["%errorlevel%"]==["0"] pause
ECHO Setting platform Variable.....
set platform=x64
if NOT ["%errorlevel%"]==["0"] pause
ECHO Setting VS_VER Variable.....
set VS_VER=15
if NOT ["%errorlevel%"]==["0"] pause
ECHO Setting VS_VCVARS Variable.....
set VS_VCVARS=14.16
if NOT ["%errorlevel%"]==["0"] pause
ECHO Setting arch Variable.....
set arch=amd64
if NOT ["%errorlevel%"]==["0"] pause
ECHO Setting VSCMD_DEBUG Variable.....
set VSCMD_DEBUG=1
if NOT ["%errorlevel%"]==["0"] pause
ECHO OFF
REM cd "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools"
REM call VsDevCmd.bat -arch=%arch% -host_arch=%arch% -vcvars_ver=%VS_VCVARS%
ECHO ON
ECHO CD to VS.....
if NOT exist "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build" echo VS 2017 not found
cd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build" || exit /b
ECHO Setting up VS.....
call vcvars64.bat || exit /b
ECHO OFF
REM cd "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC"
REM call vcvarsall.bat amd64
ECHO ON
ECHO CD to gvsbuild.....
if NOT exist "C:\gtk-build\github\gvsbuild" echo gvsbuild not found
cd C:\gtk-build\github\gvsbuild || exit /b
ECHO OFF
REM %PYTHON% build.py build --archives-download-dir=%DOWNLOAD_DIR% --platform=x64 --vs-ver=%VS_VER% --python-dir=C:\Python\Python37 -k --enable-gi --py-wheel --py-egg --python-ver 3.7 enchant gtk gtk3-full pycairo pygobject lz4
ECHO ON
python build.py build -v -d --gtk3-ver=3.24 --archives-download-dir=%DOWNLOAD_DIR% --vs-ver=%VS_VER% --platform=x64 --vs-install-path="c:\Program Files (x86)\Microsoft Visual Studio\2017\Community" --python-dir=C:\Python\Python37 -k --enable-gi --py-wheel --py-egg --python-ver=3.7 enchant gtk gtk3-full pycairo pygobject lz4 || exit /b
IF "%PLATFORM%"=="x86" tar.exe -zcf gvsbuild-vs%VS_VER%-%PLATFORM%-%PYTHONVER%.tar.gz -C c:/gtk-build/gtk/Win32 release || exit /b
IF "%PLATFORM%"=="x64" tar.exe -zcf gvsbuild-vs%VS_VER%-%PLATFORM%-%PYTHONVER%.tar.gz -C c:/gtk-build/gtk/x64 release || exit /b
