from PyInstaller.utils.hooks import copy_metadata
import os
import site
import sys

#typelib_path = os.path.join(site.getsitepackages()[1], 'gnome', 'lib', 'girepository-1.0')
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

    kwargs.setdefault('hiddenimports', [])
    kwargs.setdefault('datas', copy_metadata('Deluge'))
    kwargs.setdefault('binaries', [(os.path.join(typelib_path, tl), 'gi_typelibs') for tl in os.listdir(typelib_path)])
    kwargs.setdefault('excludes', [])
    kwargs.setdefault('pathex', ['C:\\gtk-build\\gtk\\x64\\release\\bin', 'C:\\gtk-build\\gtk\\x64\\release\\lib'])
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

a = Entrypoint('deluge==2.0.4', 'console_scripts', 'deluge-console')
b = Entrypoint('deluge==2.0.4', 'console_scripts', 'deluge-web')
c = Entrypoint('deluge==2.0.4', 'console_scripts', 'deluged')
if sys.platform == 'win32':
    d = Entrypoint('deluge==2.0.4', 'console_scripts', 'deluge-debug')
    e = Entrypoint('deluge==2.0.4', 'console_scripts', 'deluge-web-debug')
    f = Entrypoint('deluge==2.0.4', 'console_scripts', 'deluged-debug')

g = Entrypoint('deluge==2.0.4', 'gui_scripts', 'deluge')
h = Entrypoint('deluge==2.0.4', 'gui_scripts', 'deluge-gtk')

i = Entrypoint('deluge==2.0.4', 'deluge.ui', 'console')
j = Entrypoint('deluge==2.0.4', 'deluge.ui', 'web')
k = Entrypoint('deluge==2.0.4', 'deluge.ui', 'gtk')

#a.binaries + [('msvcp100.dll', 'C:\\Windows\\System32\\msvcp100.dll', 'BINARY'),
#              ('msvcr100.dll', 'C:\\Windows\\System32\\msvcr100.dll', 'BINARY')]
#a.datas + copy_metadata('Deluge'),
 

pyz = PYZ(h.pure, h.zipped_data)
exe = EXE(pyz,
          h.scripts,
          [],
          exclude_binaries=True,
          name='Deluge',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=True )


coll = COLLECT(exe,
               h.binaries,
               h.zipfiles,
               h.datas,
               strip=False,
               upx=True,
               upx_exclude=[],
               name='Deluge')
