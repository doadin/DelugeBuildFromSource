set PATH=C:\Program Files\NASM;C:\Perl64\bin;%PATH%
cd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build"
call vcvars64.bat
cd C:\SpenSSL
perl configure VC-WIN64A --prefix=C:\OpenSSL-Win64
nmake
nmake test
nmake install
