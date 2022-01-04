# -*- mode: python ; coding: utf-8 -*-
from PyInstaller.utils.hooks import collect_all

datas = []
binaries = []
extendpathdeluge=['C:\\gtk-build\\gtk\\x64\\release\\bin', 'C:\\gtk-build\\gtk\\x64\\release\\lib', "C:\\gtk-build\\gtk\\x64\\release\\share", 'C:\\OpenSSL-Win64\\bin',]
hiddenimports = ['gi', 'cairo', 'deluge']
tmp_ret = collect_all('deluge')
datas += tmp_ret[0]; binaries += tmp_ret[1]; hiddenimports += tmp_ret[2]


block_cipher = None

#deluge-script.pyw
a = Analysis(['deluge-script.pyw'],
             pathex=extendpathdeluge,
             binaries=binaries,
             datas=datas,
             hiddenimports=hiddenimports,
             hookspath=[],
             hooksconfig={},
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)

exe = EXE(pyz,
          a.scripts, 
          [],
          exclude_binaries=True,
          name='deluge',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=False,
          disable_windowed_traceback=False,
          target_arch=None,
          codesign_identity=None,
          entitlements_file=None )

#deluge-web-script.pyw
b = Analysis(['deluge-web-script.pyw'],
             pathex=extendpathdeluge,
             binaries=binaries,
             datas=datas,
             hiddenimports=hiddenimports,
             hookspath=[],
             hooksconfig={},
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
pyzb = PYZ(b.pure, b.zipped_data,
             cipher=block_cipher)

exeb = EXE(pyzb,
          b.scripts, 
          [],
          exclude_binaries=True,
          name='deluge-web',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=False,
          disable_windowed_traceback=False,
          target_arch=None,
          codesign_identity=None,
          entitlements_file=None )

#deluge-gtk-script.pyw
c = Analysis(['deluge-gtk-script.pyw'],
             pathex=extendpathdeluge,
             binaries=binaries,
             datas=datas,
             hiddenimports=hiddenimports,
             hookspath=[],
             hooksconfig={},
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
pyzc = PYZ(c.pure, c.zipped_data,
             cipher=block_cipher)

exec = EXE(pyzc,
          c.scripts, 
          [],
          exclude_binaries=True,
          name='deluge-gtk',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=False,
          disable_windowed_traceback=False,
          target_arch=None,
          codesign_identity=None,
          entitlements_file=None )

#deluged-script.pyw
d = Analysis(['deluged-script.pyw'],
             pathex=extendpathdeluge,
             binaries=binaries,
             datas=datas,
             hiddenimports=hiddenimports,
             hookspath=[],
             hooksconfig={},
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
pyzd = PYZ(d.pure, d.zipped_data,
             cipher=block_cipher)

exed = EXE(pyzd,
          d.scripts, 
          [],
          exclude_binaries=True,
          name='deluged',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          icon='deluge/ui/data/pixmaps/deluge.ico',
          console=False,
          disable_windowed_traceback=False,
          target_arch=None,
          codesign_identity=None,
          entitlements_file=None )


#End
coll = COLLECT(exe,
               exeb,
               exec,
               exed,
               a.binaries,
               a.zipfiles,
               a.datas, 
               strip=False,
               upx=True,
               upx_exclude=[],
               name='Deluge')
