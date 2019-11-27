How to build deluge and dependencies 100% from source.

You need to have installed:

Python(https://www.python.org/ftp/python/3.7.5/python-3.7.5-amd64.exe)

nasm(https://www.nasm.us/pub/nasm/releasebuilds/2.14.02/win64/nasm-2.14.02-installer-x64.exe)

ActivePerl(https://platform.activestate.com/ActiveState/ActivePerl-5.28/auto-fork?utm_campaign=fork-perl&utm_medium=website&utm_source=activestate.com&utm_term=perl5.28&utm_content=fork-activeperl5.28)

Then download boost https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.zip

And Extract to C:\

Download gvsbuild(https://github.com/cas--/gvsbuild/archive/master.zip)

And Extract to C:\gtk-build\github

Download Libtorrent(https://github.com/arvidn/libtorrent/archive/RC_1_2.zip)

And Extract to C:\

Download Deluge(https://github.com/deluge-torrent/deluge/archive/develop.zip)

And Extract to C:\

Make sure the following are in your %PATH% environment variable.

C:\Perl64\site\bin

C:\Perl64\bin

C:\Python\Python37

C:\Python\Python37\Scripts

C:\gtk-build\gtk\x64\release\bin

From there run:
1. OpenSSLBuild.bat
2. LibtorrentBuild.bat
3. GTK3Build.bat
4. DelugeBuild.bat

From here you can cmd/powershell deluge.exe or create a shortcut from C:\Python\Python37\Scripts .
