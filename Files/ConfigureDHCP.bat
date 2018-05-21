@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Sample configuration DHCP-server
set USAGE=edit this file

goto Finish

set DHCP_IMPORT=C:\dhcp.dat
set DHCP_BACKUP=C:\BACKUP\DHCP

:Delete_Role_DHCPServer
call EchoTitl Delete role DHCP-server
call DeleteDHCPAllScopes
for %%i in (%DHCP_BACKUP%) do call TaskBackupDHCP Delete "%%i"
:: call RoleDHCPServer Delete

:Add_Role_DHCPServer
call EchoTitl Add role DHCP-server
call RoleDHCPServer Add
for %%i in (%DHCP_BACKUP%) do call TaskBackupDHCP Add "%%i"

:Import_DHCPServer_Params
call EchoTitl Set DHCP-server params
call ImportDHCP "%DHCP_IMPORT%" && goto Set_DHCP_DNSCredentials

:Set_DHCPServer_Params
call EchoTitl Set DHCP-server params
call SetDHCPDNSSuffix    tm.local
call SetDHCPDNSServers   10.130.0.2 10.124.4.2 10.125.4.2 10.124.4.3
call SetDHCPNTPServers   10.130.0.2 10.124.4.2 10.125.4.2 10.124.4.3
call SetDHCPTFTPServer   10.124.4.130

call AddDHCPScope        10.130.0.0 255.255.0.0 LAN-BLK
call SetDHCPScopeRange   10.130.0.0 10.130.200.20 10.130.200.200
call SetDHCPScopeGateway 10.130.0.0 10.130.0.1

call AddDHCPScopeIP      10.130.0.0 10.130.1.101    e0:cb:4e:5d:0d:cd  pc1917
call AddDHCPScopeIP      10.130.0.0 10.130.1.102    e0:cb:4e:5d:0d:05  pc1923
call AddDHCPScopeIP      10.130.0.0 10.130.1.103    e0:cb:4e:95:24:58  pc2125
call AddDHCPScopeIP      10.130.0.0 10.130.1.104    e0:cb:4e:5d:0a:c6  pc2131
call AddDHCPScopeIP      10.130.0.0 10.130.1.105    48:5b:39:90:4b:c4  pc2158
call AddDHCPScopeIP      10.130.0.0 10.130.1.106    e0:69:95:4f:18:0a  pc2697
call AddDHCPScopeIP      10.130.0.0 10.130.1.107    94:de:80:a5:2e:15  pc3208
call AddDHCPScopeIP      10.130.0.0 10.130.1.108    94:de:80:a8:15:cf  pc3209
call AddDHCPScopeIP      10.130.0.0 10.130.1.201    44:1e:a1:e5:f5:d7  nb267
call AddDHCPScopeIP      10.130.0.0 10.130.1.251    2c:8a:72:a9:c3:7a  android-1c3ac8bfd6f6289b
call AddDHCPScopeIP      10.130.0.0 10.130.1.252    ec:9b:f3:72:a4:60  android-6dc9592b8098ce2c

call AddDHCPScopeIP      10.130.0.0 10.130.2.101    e0:cb:4e:5d:0d:cc  pc1918
call AddDHCPScopeIP      10.130.0.0 10.130.2.102    e0:cb:4e:5d:0d:81  pc1921
call AddDHCPScopeIP      10.130.0.0 10.130.2.103    e0:cb:4e:95:23:fe  pc1922
call AddDHCPScopeIP      10.130.0.0 10.130.2.104    e0:cb:4e:5d:0a:a5  pc1925
call AddDHCPScopeIP      10.130.0.0 10.130.2.105    e0:cb:4e:5d:0a:d5  pc1926
call AddDHCPScopeIP      10.130.0.0 10.130.2.106    20:cf:30:19:fb:33  pc2121
call AddDHCPScopeIP      10.130.0.0 10.130.2.107    e0:cb:4e:5d:0d:d5  pc2124
call AddDHCPScopeIP      10.130.0.0 10.130.2.108    e0:cb:4e:5d:0d:df  pc2126
call AddDHCPScopeIP      10.130.0.0 10.130.2.109    e0:cb:4e:5d:0a:a7  pc2127
call AddDHCPScopeIP      10.130.0.0 10.130.2.110    e0:cb:4e:5d:0a:d9  pc2128
call AddDHCPScopeIP      10.130.0.0 10.130.2.111    e0:cb:4e:5d:0a:e1  pc2129
call AddDHCPScopeIP      10.130.0.0 10.130.2.112    e0:cb:4e:95:24:34  pc2130
call AddDHCPScopeIP      10.130.0.0 10.130.2.113    bc:ae:c5:39:2e:83  pc2620
call AddDHCPScopeIP      10.130.0.0 10.130.2.114    bc:ae:c5:39:2e:9f  pc2621
call AddDHCPScopeIP      10.130.0.0 10.130.2.115    bc:ae:c5:39:2d:1d  pc2622
call AddDHCPScopeIP      10.130.0.0 10.130.2.116    e0:69:95:4f:0c:91  pc2690
call AddDHCPScopeIP      10.130.0.0 10.130.2.117    e0:69:95:4f:17:c5  pc2691
call AddDHCPScopeIP      10.130.0.0 10.130.2.118    e0:69:95:4f:0d:f1  pc2692
call AddDHCPScopeIP      10.130.0.0 10.130.2.119    e0:69:95:4f:0d:8d  pc2694
call AddDHCPScopeIP      10.130.0.0 10.130.2.120    e0:69:95:4f:0d:09  pc2695
call AddDHCPScopeIP      10.130.0.0 10.130.2.121    e0:69:95:4f:0d:03  pc2696
call AddDHCPScopeIP      10.130.0.0 10.130.2.122    e0:69:95:4f:0c:7a  pc2698
call AddDHCPScopeIP      10.130.0.0 10.130.2.123    e0:69:95:4f:17:79  pc2699

call AddDHCPScopeIP      10.130.0.0 10.130.254.101  40:f4:ec:ee:41:4e  SEP40F4ECEE414E
call AddDHCPScopeIP      10.130.0.0 10.130.254.102  40:f4:ec:ee:41:bb  SEP40F4ECEE41BB
call AddDHCPScopeIP      10.130.0.0 10.130.254.103  40:f4:ec:ee:59:d8  SEP40F4ECEE59D8
call AddDHCPScopeIP      10.130.0.0 10.130.254.104  40:f4:ec:ee:cd:38  SEP40F4ECEECD38
call AddDHCPScopeIP      10.130.0.0 10.130.254.105  c0:62:6b:62:c6:df  SEPC0626B62C6DF
call AddDHCPScopeIP      10.130.0.0 10.130.254.106  e8:04:62:ea:4f:dc  SEPE80462EA4FDC

:Set_DHCP_DNSCredentials
call SetDHCPDNSCredentials
call AuthorizeDHCP "dc-blk.tm.local" "10.130.0.2"

:Finish
