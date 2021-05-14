:: The script will configure http to https redirection for Outlook on the web in Exchange Server
:: Author: Keith Weaver
:: https://docs.microsoft.com/en-us/exchange/clients/outlook-on-the-web/http-to-https-redirection?view=exchserver-2016

:: Remove the Require SSL setting from the default website
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site" -section:access -sslFlags:None -commit:APPHOST

:: Restore the Require SSL setting on other virtual directories in the default website
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/API" -section:Access -sslFlags:Ssl,Ssl128 -commit:APPHOST
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/aspnet_client" -section:Access -sslFlags:Ssl,Ssl128 -commit:APPHOST
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/Autodiscover" -section:Access -sslFlags:Ssl,Ssl128 -commit:APPHOST
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/ecp" -section:Access -sslFlags:Ssl,Ssl128 -commit:APPHOST
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/EWS" -section:Access -sslFlags:Ssl,Ssl128 -commit:APPHOST
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/mapi" -section:Access -sslFlags:Ssl,Ssl128 -commit:APPHOST
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/Microsoft-Server-ActiveSync" -section:Access -sslFlags:Ssl,Ssl128 -commit:APPHOST
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/OAB" -section:Access -sslFlags:Ssl,Ssl128 -commit:APPHOST


:: Configure the default website to redirect to the /owa virtual directory
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site" -section:httpredirect -enabled:true -destination:"/owa" -childOnly:true

:: Remove http redirection from all virtual directories in the default website
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/API" -section:httpredirect -enabled:false -destination:"" -childOnly:false
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/aspnet_client" -section:httpredirect -enabled:false -destination:"" -childOnly:false
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/Autodiscover" -section:httpredirect -enabled:false -destination:"" -childOnly:false
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/ecp" -section:httpredirect -enabled:false -destination:"" -childOnly:false
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/EWS" -section:httpredirect -enabled:false -destination:"" -childOnly:false
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/mapi" -section:httpredirect -enabled:false -destination:"" -childOnly:false
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/Microsoft-Server-ActiveSync" -section:httpredirect -enabled:false -destination:"" -childOnly:false
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/OAB" -section:httpredirect -enabled:false -destination:"" -childOnly:false
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/owa" -section:httpredirect -enabled:false -destination:"" -childOnly:false
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/PowerShell" -section:httpredirect -enabled:false -destination:"" -childOnly:false
%windir%\system32\inetsrv\appcmd.exe set config "Default Web Site/Rpc" -section:httpredirect -enabled:false -destination:"" -childOnly:false

:: Restart IIS
net stop was /y
net start w3svc