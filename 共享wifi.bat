@echo off
title wifi����С���� @author liqiyuan
:begin
echo    ******************************************************
echo    *                   wifi����С����                   *  
echo    *            ����wifi�밴1                           *  
echo    *            �ر�wifi�밴2                           *
echo    *            ����wifi�����밴3                       *
echo    *            �˳������밴4                           *
echo    ******************************************************
choice /c 1234 /m ѡ����Ҫ���еĲ���>nul
if errorlevel 4 goto exit
if errorlevel 3 goto setting
if errorlevel 2 goto close
if errorlevel 1 goto open
if errorlevel 0 goto error
:setting
netsh wlan set hostednetwork mode=allow
set /p wlanname="������wifi����"
netsh wlan set hostednetwork ssid=%wlanname%
set /p password="������wifi���룺"
netsh wlan set hostednetwork key=%password%
netsh wlan start hostednetwork
echo *********wifi���óɹ���wifi��Ϊ%wlanname%, ����Ϊ%password%
pause
goto begin
:open
netsh wlan start hostednetwork
echo *********wifi�ѿ���
pause
goto begin
:close
netsh wlan stop hostednetwork
echo *********wifi�ѹر�
pause
goto begin
:error
echo δ֪����������!
pause
goto begin
:exit
exit
pause