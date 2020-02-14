from PyInstaller.utils.hooks import copy_metadata
from PyInstaller.utils.hooks import collect_submodules
import os
import pkg_resources
import site
import sys
import deluge.common

#typelib_path = os.path.join(site.getsitepackages()[1], 'gnome', 'lib', 'girepository-1.0')
#C:\\gtk-build\\gtk\\x64\\release\\lib\\girepository-1.0
#C:\\gtk-build\\gtk\\x64\\release\\lib
if sys.platform == 'win32':
    typelib_path = 'C:\\gtk-build\\gtk\\x64\\release\\lib\\girepository-1.0'
if sys.platform == 'darwin':
    typelib_path = '/usr/local/lib/girepository-1.0' # Or Something like that?


def Entrypoint(dist, group, name, **kwargs):
    import pkg_resources

    # get toplevel packages of distribution from metadata
    def get_toplevel(dist):
        distribution = pkg_resources.get_distribution(dist)
        if distribution.has_metadata('top_level.txt'):
            return list(distribution.get_metadata('top_level.txt').split())
        else:
            return []

    kwargs.setdefault('hiddenimports', ["twisted"])
    #kwargs.setdefault('excluded_binaries', [])
    kwargs.setdefault('datas', copy_metadata('Deluge'))
    #kwargs.setdefault('binaries', [(os.path.join(typelib_path, tl), 'gi_typelibs') for tl in os.listdir(typelib_path)])
    kwargs.setdefault('excludes', [
    "win32com.gen_py",
    "pyimod03_importers",
    "pkg_resources.extern.pyparsing",
    "_uuid",
    "__builtin__",
    "ordereddict",
    "StringIO",
    "com.sun",
    "com",
    "_scproxy",
    "site",
    "macholib.MachO",
    "macholib",
    "_pkgutil",
    "dis3",
    "urllib.pathname2url",
    "pyimod00_crypto_key",
    "thread",
    "macholib.dyld",
    "macholib.mach_o",
    "Crypto",
    "win32ctypes.core._time",
    "win32ctypes.core._system_information",
    "win32ctypes.core._resource",
    "win32ctypes.core._dll",
    "win32ctypes.core._common",
    "win32ctypes.core._authentication",
    "multiprocessing.set_start_method",
    "multiprocessing.get_start_method",
    "multiprocessing.get_context",
    "multiprocessing.TimeoutError",
    "multiprocessing.BufferTooShort",
    "multiprocessing.AuthenticationError",
    "dummy_thread",
    "setuptools.extern.six.moves",
    "setuptools.extern.six.moves.filterfalse",
    "setuptools.extern.six.moves.filter",
    "setuptools.extern.six.moves.map",
    "setuptools.extern.six",
    "setuptools.extern.ordered_set",
    "setuptools.extern.packaging",
    "setuptools._vendor.six.moves",
    "setuptools.extern.pyparsing",
    "numpy",
    "setuptools.extern.packaging.version",
    "setuptools.extern.packaging.utils",
    "setuptools.extern.packaging.specifiers",
    "_manylinux",
    "wincertstore",
    "backports.ssl_match_hostname",
    "backports",
    "setuptools.extern.six",
    "cStringIO",
    "copy_reg",
    "cPickle",
    "cffi._pycparser",
    "UserDict",
    "pkg_resources.extern.packaging",
    "pkg_resources.extern.appdirs",
    "pkg_resources.extern.six.moves",
    "pkg_resources.extern.six",
    "multiprocessing.forking",
    "fcntl",
    "cookielib",
    "urllib.unquote",
    "urllib.quote",
    "urlparse",
    "asyncio.DefaultEventLoopPolicy",
    "Queue",
    "twisted.python._sendmsg",
    "six.moves.range",
    "six.moves",
    "resource",
    "posix",
    "_posixsubprocess",
    "readline",
    "termios",
    "grp",
    "org.python",
    "dbus",
    "gi.repository.GdkX11",
    "gi.repository.GstPbutils",
    "gi.repository.GooCanvas",
    "gi.repository.GstController",
    "gi.repository.GstInterfaces",
    "gi.repository.GUdev",
    "gi.repository.WebKit",
    "gi.repository.Poppler",
    "PySide.QtCore",
    "PyQt4.QtCore",
    "PySide2.QtCore",
    "PySide2",
    "PyQt5.QtCore"])
    kwargs.setdefault('pathex', ['C:\\gtk-build\\gtk\\x64\\release\\bin', 'C:\\gtk-build\\gtk\\x64\\release\\lib', "C:\\gtk-build\\gtk\\x64\\release\\share"])
    kwargs.setdefault('win_no_prefer_redirects', 'False')
    kwargs.setdefault('win_private_assemblies', 'False')
    packages = []
    for distribution in kwargs['hiddenimports']:
        packages += get_toplevel(distribution)

    # get the entry point
    ep = pkg_resources.get_entry_info(dist, group, name)
    # insert path of the egg at the verify front of the search path
    kwargs['pathex'] = [ep.dist.location] + kwargs['pathex']
    # script name must not be a valid module name to avoid name clashes on import
    script_path = os.path.join(workpath, name + '-script.py')
    print("creating script for entry point", dist, group, name)
    with open(script_path, 'w') as fh:
        print("import", ep.module_name, file=fh)
        print("%s.%s()" % (ep.module_name, '.'.join(ep.attrs)), file=fh)
        for package in packages:
            print("import", package, file=fh)

    return Analysis(
        [script_path] + kwargs.get('scripts', []),
        **kwargs
    )
getversion = str(deluge.common.get_version())
version = ''' + getversion + '''
#a = Entrypoint('deluge==2.0.4', 'console_scripts', 'deluge-console')
b = Entrypoint(version', 'console_scripts', 'deluge-web')
c = Entrypoint(version, 'console_scripts', 'deluged')
if sys.platform == 'win32':
    #d = Entrypoint('deluge==2.0.3', 'console_scripts', 'deluge-debug')
    e = Entrypoint(version, 'console_scripts', 'deluge-web-debug')
    f = Entrypoint(version, 'console_scripts', 'deluged-debug')

g = Entrypoint(version, 'gui_scripts', 'deluge')
h = Entrypoint(version, 'gui_scripts', 'deluge-gtk')

#i = Entrypoint('deluge==2.0.4', 'deluge.ui', 'console')
#j = Entrypoint('deluge==2.0.4', 'deluge.ui', 'web')
#k = Entrypoint('deluge==2.0.4', 'deluge.ui', 'gtk')

#options = [ ('v', None, 'OPTION'), ('W ignore', None, 'OPTION') ]

pyz = PYZ(h.pure, h.zipped_data)
exe = EXE(pyz,
          h.scripts,
          [],
          exclude_binaries=True,
          name='deluge-gtk',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=False,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=True )

pyz2 = PYZ(c.pure, c.zipped_data)
exe2 = EXE(pyz2,
          c.scripts,
          [],
          exclude_binaries=True,
          name='deluged',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=False,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=False )

pyz3 = PYZ(b.pure, b.zipped_data)
exe3 = EXE(pyz3,
          b.scripts,
          [],
          exclude_binaries=True,
          name='deluge-web',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=False,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=False )

pyz4 = PYZ(f.pure, f.zipped_data)
exe4 = EXE(pyz4,
          f.scripts,
          [],
          exclude_binaries=True,
          name='deluged-debug',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=False,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=True )

#pyz5 = PYZ(d.pure, d.zipped_data)
#exe5 = EXE(pyz5,
#          d.scripts,
#          [],
#          exclude_binaries=True,
#          name='deluge-debug',
#          debug=False,
#          bootloader_ignore_signals=False,
#          strip=False,
#          upx=False,
#          icon='deluge/ui/data/pixmaps/deluge.ico',
#          console=False )

pyz6 = PYZ(e.pure, e.zipped_data)
exe6 = EXE(pyz6,
          e.scripts,
          [],
          exclude_binaries=True,
          name='deluge-web-debug',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=False,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=True )

pyz7 = PYZ(g.pure, g.zipped_data)
exe7 = EXE(pyz7,
          g.scripts,
          [],
          exclude_binaries=True,
          name='deluge',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=False,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=False )


coll = COLLECT(exe,
               h.binaries,
               h.zipfiles,
               h.datas,
               exe2,
               exe3,
               exe4,
               exe6,
               exe7,
               strip=False,
               upx=False,
               upx_exclude=[],
               name='Deluge')


if sys.platform == 'darwin':
  app = BUNDLE(coll,
               name=name,
               icon="../../data/images/exaile.icns",
               bundle_identifier=None)


