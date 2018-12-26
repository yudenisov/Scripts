; -- Util.iss --
;
; This script Create Installator and deinstallator of the
; C:\Util catalog

[Setup]
AppName=Some Admin Scripts Set 01
AppVersion=0.2.0
AllowRootDirectory=yes
AllowCancelDuringInstall=yes
ArchitecturesAllowed=x86 x64
Compression=lzma2/max
DefaultDirName={%UTIL|c:\Util}
MinVersion=6.0.6001
SetupLogging=yes
UsePreviousAppDir=yes
DisableStartupPrompt=yes
Output=no
OutputDir=d:\Download
OutputBaseFilename=AdminScriptsSet01

[Files]

Source: "*.*"; DestDir: "{app}"; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace

[UninstallRun]

