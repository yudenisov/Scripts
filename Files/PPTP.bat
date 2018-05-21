@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Manage PPTP-connections [with GUI]
set USAGE=[delete/add connection_name [server user password [dns-suffix]]]

if /I "%~1"==""       call :Start_GUI_PPTP
if /I "%~1"=="DELETE" call :Delete_PPTP "%~2"
if /I "%~1"=="ADD"    call :Add_PPTP    "%~2" "%~3" "%~4" "%~5" "%~6"
goto Finish


:Start_GUI_PPTP
start %~n0.hta
exit /B

:Delete_PPTP
if "%~1"=="" exit /B 255
set RASPHONE_DIR=%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Connections\Pbk
set RASPHONE_PBK=%RASPHONE_DIR%\rasphone.pbk
mkdir>nul 2>nul "%RASPHONE_DIR%"
nircmd.exe>nul 2>nul inidelsec "%RASPHONE_PBK%" "%~1"
%SystemRoot%\System32\find.exe>nul 2>nul /I "[%~1]" "%RASPHONE_PBK%" && (
  call EchoFail Delete PPTP-connection "%~1"
  exit /B 1
)
call EchoSucc Delete PPTP-connection "%~1"
exit /B 0

:Add_PPTP
:: Форматы файла rasphone.pbk в Win2k и WinXP различны.
:: -----------------------------------------------------------------------------
:: DataEncryption=256    (Def) - [x] Требуется шифрование данных
:: DataEncryption=8            - [ ] Требуется шифрование данных
:: -----------------------------------------------------------------------------
:: RedialAttempts=3      (Def) - Число повторений набора номера: 3
:: RedialAttempts=999999       - Число повторений набора номера: 999999
:: -----------------------------------------------------------------------------
:: RedialSeconds=60      (Def) - Интервал между повторениями: 1 минута
:: RedialSeconds=10            - Интервал между повторениями: 10 секунд
:: -----------------------------------------------------------------------------
:: RedialOnLinkFailure=0 (Def) - [ ] Перезвонить при разрыве связи
:: RedialOnLinkFailure=1       - [x] Перезвонить при разрыве связи
:: -----------------------------------------------------------------------------
:: ShowDialingProgress=1 (Def) - [x] Отображать ход подключения
:: ShowDialingProgress=0       - [ ] Отображать ход подключения
:: -----------------------------------------------------------------------------
:: IpPrioritizeRemote=1  (Def) - [x] Использовать основной шлюз в удалённой сети
:: IpPrioritizeRemote=0        - [ ] Использовать основной шлюз в удалённой сети
:: -----------------------------------------------------------------------------
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
if "%~3"=="" exit /B 255
if "%~4"=="" exit /B 255
set RASPHONE_DIR=%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Connections\Pbk
set RASPHONE_PBK=%RASPHONE_DIR%\rasphone.pbk
mkdir>nul 2>nul "%RASPHONE_DIR%"
nircmd.exe>nul 2>nul inidelsec "%RASPHONE_PBK%" "%~1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "Encoding"                 "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "Type"                     "2"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "AutoLogon"                "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "UseRasCredentials"        "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "BaseProtocol"             "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "VpnStrategy"              "2"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "ExcludedProtocols"        "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "LcpExtensions"            "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "DataEncryption"           "8"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "SwCompression"            "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "NegotiateMultilinkAlways" "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "SkipNwcWarning"           "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "SkipDownLevelDialog"      "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "SkipDoubleDialDialog"     "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "DialMode"                 "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "DialPercent"              "75"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "DialSeconds"              "120"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "HangUpPercent"            "10"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "HangUpSeconds"            "120"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "OverridePref"             "15"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "RedialAttempts"           "999999"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "RedialSeconds"            "10"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IdleDisconnectSeconds"    "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "RedialOnLinkFailure"      "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "CallbackMode"             "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "AuthenticateServer"       "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "ShareMsFilePrint"         "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "BindMsNetClient"          "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "SharedPhoneNumbers"       "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "GlobalDeviceSettings"     "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreferredPort"            "VPN2-0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreferredDevice"          "Miniport WAN (L2TP)"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreferredBps"             "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreferredHwFlow"          "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreferredProtocol"        "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreferredCompression"     "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreferredSpeaker"         "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreferredMdmProtocol"     "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreviewUserPw"            "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreviewDomain"            "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PreviewPhoneNumber"       "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "ShowDialingProgress"      "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "ShowMonitorIconInTaskBar" "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "CustomAuthKey"            "-1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "AuthRestrictions"         "608"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "TypicalAuth"              "2"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpPrioritizeRemote"       "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpHeaderCompression"      "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpAddress"                "0.0.0.0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpDnsAddress"             "0.0.0.0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpDns2Address"            "0.0.0.0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpWinsAddress"            "0.0.0.0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpWins2Address"           "0.0.0.0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpAssign"                 "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpNameAssign"             "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpFrameSize"              "1006"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpDnsFlags"               "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpNBTFlags"               "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "TcpWindowSize"            "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "UseFlags"                 "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpSecFlags"               "0"
if not "%~5"=="" ^
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "IpDnsSuffix"              "%~5"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "ms_server"                "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "ms_msclient"              "1"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "MEDIA"                    "rastapi"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "Port"                     "VPN2-0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "DEVICE"                   "vpn"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PhoneNumber"              "%~2"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "CountryCode"              "7"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "CountryID"                "7"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "UseDialingRules"          "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "LastSelectedPhone"        "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "PromoteAlternates"        "0"
nircmd.exe>nul 2>nul inisetval "%RASPHONE_PBK%" "%~1" "TryNextAlternateOnFail"   "1"
nircmd.exe>nul 2>nul setdialuplogon "%~1" "%~3" "%~4"
%SystemRoot%\System32\find.exe>nul 2>nul /I "[%~1]" "%RASPHONE_PBK%" && (
  call EchoSucc Add PPTP-connection "%~1" to server "%~2" as user "%~3"
  exit /B 0
)
call EchoFail Add PPTP-connection "%~1" to server "%~2" as user "%~3"
exit /B 1

:Finish
