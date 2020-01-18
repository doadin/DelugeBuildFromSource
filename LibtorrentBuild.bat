set VS_VER=15
set VS_VCVARS=14.16
set arch=amd64
cd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build"
call vcvars64.bat
set PYTHON_PATH=C:\Python\Python37
set INCLUDE=C:\OpenSSL-Win64\include;%INCLUDE%
set LIB=C:\OpenSSL-Win64\lib;%LIB%
set BOOST_ROOT=C:\boost_1_70_0
set BOOST_BUILD_PATH=%BOOST_ROOT%
set VS_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Tools\MSVC\14.16.27023\bin\Hostx64\x64
set OPENSSL_PATH=C:\OpenSSL-Win64\bin
set PATH=%BOOST_ROOT%;%VS_PATH%;%PYTHON_PATH%;%OPENSSL_PATH%;%PATH%

cd C:\libtorrent-RC_1_2\bindings\python
b2 libtorrent-link=static boost-link=static release toolset=msvc-14.1 optimization=space runtime-link=static link=static python=3.7 address-model=64 crypto=openssl
