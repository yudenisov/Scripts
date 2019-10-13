; -- Util.iss --
;
; This script Create Installator and deinstallator of the
; C:\Util catalog

[Setup]
AppName=Admin Scripts Set 01
AppVersion=1.0.0.0
AllowCancelDuringInstall=yes
ArchitecturesAllowed=x86 x64
Compression=lzma2/max
MinVersion=0,6.0
SetupLogging=yes
DisableStartupPrompt=yes
Output=yes
OutputDir=d:\Download
OutputBaseFilename=AdminScriptsSet01
AppId={{20B1746C-65AE-48EA-A4F2-53E5879B48F1}
LicenseFile=userdocs:GitHub\Scripts\license.rtf
RestartIfNeededByRun=False
CreateAppDir=False
AppPublisher=New Internet Technologies Inc.
AppPublisherURL=http://github.com/yudenisov/Scripts/
AppSupportURL=http://github.com/yudenisov/Scripts/
AppUpdatesURL=http://github.com/yudenisov/Scripts/
AppSupportPhone=+79047071125
UninstallFilesDir={win}
VersionInfoVersion=1.0.0.0
VersionInfoCompany=New Internet Technologies Inc.
VersionInfoCopyright=(C) 2015-2019 yudenisov
VersionInfoProductName=Admin Scripts Set 01
VersionInfoProductVersion=1.0.0.0
VersionInfoProductTextVersion=1.0.0.0_alpha

[Files]

Source: "*.*"; DestDir: "{win}"; Flags: recursesubdirs uninsremovereadonly uninsrestartdelete restartreplace

[Registry]

Root: HKCU; Subkey: "Software\Sysinternals\C"; Flags: deletevalue noerror uninsdeletevalue; ValueType: dword; ValueName: "EulaAccepted"; ValueData: "1"
Root: HKCU; Subkey: "Software\Sysinternals\PSExec"; Flags: deletevalue noerror uninsdeletevalue; ValueType: dword; ValueName: "EulaAccepted"; ValueData: "1"
Root: HKCU; Subkey: "Software\Sysinternals\psx"; Flags: deletevalue noerror uninsdeletevalue; ValueType: dword; ValueName: "EulaAccepted"; ValueData: "1"
Root: HKCU; Subkey: "Software\Sysinternals\Regjump"; Flags: deletevalue noerror uninsdeletevalue; ValueType: dword; ValueName: "EulaAccepted"; ValueData: "1"

[UninstallRun]
Filename: "{sys}\schtasks.exe"; Parameters: "/F /DELETE /TN ""Admin_Scripts"""; WorkingDir: "{sys}"; Flags: runhidden skipifdoesntexist
Filename: "{sys}\reg.exe"; Parameters: "delete ""HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"" /F"; WorkingDir: "{sys}"; Flags: runhidden
Filename: "{sys}\reg.exe"; Parameters: "delete ""HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\Disallowed\Certificates"" /F"; WorkingDir: "{sys}"; Flags: runhidden
Filename: "{sys}\reg.exe"; Parameters: "delete ""HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\TrustedPublisher\Certificates"" /F"; WorkingDir: "{sys}"; Flags: runhidden

[Run]
Filename: "{sys}\reg.exe"; Parameters: "import ""%SystemRoot%\REGFILES\SRP.reg"""; WorkingDir: "{sys}"; Flags: postinstall runhidden; Description: "Install SRP"
Filename: "{sys}\reg.exe"; Parameters: "import ""%SystemRoot%\REGFILES\DisallowedCerts.reg"""; WorkingDir: "{sys}"; Flags: postinstall runhidden; Description: "Install Disallowed Certificates"
Filename: "{sys}\reg.exe"; Parameters: "import ""%SystemRoot%\REGFILES\TrustedPublisherCerts.reg"""; WorkingDir: "{sys}"; Flags: postinstall runhidden; Description: "Install Trusted Certificates"
