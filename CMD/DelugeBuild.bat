ECHO Using pip to install Deluge Dependencies.....
pip install twisted[tls] chardet mako pyxdg pillow slimit pypiwin32 pygame certifi || exit /b
ECHO CD to Deluge.....
if NOT exist "C:\deluge-develop" echo deluge source not found
cd C:\deluge-develop || exit /b
ECHO Make Relase File.....
ECHO 2.0.0 > RELEASE-VERSION
ECHO Deluge setup.py build.....
python setup.py build || exit /b
ECHO Deluge setup.py install.....
python setup.py install || exit /b
