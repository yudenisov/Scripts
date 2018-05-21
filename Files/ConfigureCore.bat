@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Sample configuration Core-server
set USAGE=edit this file

:: ---------------------------------------------------------------------
:: --- Set local administrator account and host name                 ---
:: ---------------------------------------------------------------------
:: set    HOSTNAME=dhcp
:: set  LOCALADMIN=coreadmin
:: set   LOCALPASS=Core_Admin
:: ---------------------------------------------------------------------
:: --- Set network parameters                                        ---
:: ---------------------------------------------------------------------
:: set          ID=21
:: set          IP=10.124.5.35
:: set        MASK=255.255.255.0
:: set          GW=10.124.5.33
:: set        DNS1=10.124.4.2
:: set        DNS2=10.125.4.2
:: set        DNS3=8.8.8.8
:: ---------------------------------------------------------------------
:: --- Join to domain                                                ---
:: ---------------------------------------------------------------------
:: set      DOMAIN=tm.local
:: set     DCADMIN=Администратор
:: ---------------------------------------------------------------------
:: --- Add role "DHCP Server"                                        ---
:: ---------------------------------------------------------------------
:: set   DHCP_FQDN=dhcp.tm.local
:: set DHCP_IMPORT=C:\dhcp.dat
:: set DHCP_BACKUP=C:\BACKUP\DHCP
:: ---------------------------------------------------------------------
call ApplySettingsProfile Work
:: ---------------------------------------------------------------------
call EchoTitl Set local administrator account and host name
call Account Make       "%LOCALADMIN%" "%LOCALPASS%"      || goto Finish
call AddUserToAdmins    "%LOCALADMIN%"                    || goto Finish
call AddUserToDCOMUsers "%LOCALADMIN%"                    || goto Finish
call SetHostName        "%HOSTNAME%"                      || goto Finish
:: ---------------------------------------------------------------------
call EchoTitl Set network parameters
call CheckLANInterfaces                                   || goto Finish
call WoL Enable         "%ID%"
call SetIP              "%ID%" "%IP%" "%MASK%" "%GW%"     || goto Finish
call SetDNS             "%ID%" "%DNS1%" "%DNS2%" "%DNS3%" || goto Finish
call P                  "%GW%"                            || goto Finish
:: ---------------------------------------------------------------------
call EchoTitl Join to domain
call JoinToDomain       "%DOMAIN%" "%DCADMIN%"            || goto Finish
:: ---------------------------------------------------------------------
if "%DHCP_FQDN%"==""                                         goto Finish
call EchoTitl Add role "DHCP Server"
call RoleDHCPServer Add                                   || goto Finish
call ImportDHCP         "%DHCP_IMPORT%"
call AuthorizeDHCP      "%DHCP_FQDN%" "%IP%"              || goto Finish
for %%i in (%DHCP_BACKUP%) do call TaskBackupDHCP Add "%%i"

:Finish
