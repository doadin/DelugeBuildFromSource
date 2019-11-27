set PATH=C:\Program Files\NASM;C:\Perl64\bin;%PATH%
cd "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build"
call vcvars64.bat
cd C:\openssl-master
perl configure VC-WIN64A --prefix=C:\Build-OpenSSL_1_1_0-VC15-64
nmake
nmake test
nmake install
