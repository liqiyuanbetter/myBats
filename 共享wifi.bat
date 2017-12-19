@echo off
title wifi共享小工具 @author liqiyuan
:begin
echo    ******************************************************
echo    *                   wifi共享小工具                   *  
echo    *            开启wifi请按1                           *  
echo    *            关闭wifi请按2                           *
echo    *            设置wifi属性请按3                       *
echo    *            退出程序请按4                           *
echo    ******************************************************
choice /c 1234 /m 选择您要进行的操作>nul
if errorlevel 4 goto exit
if errorlevel 3 goto setting
if errorlevel 2 goto close
if errorlevel 1 goto open
if errorlevel 0 goto error
:setting
netsh wlan set hostednetwork mode=allow
set /p wlanname="请输入wifi名："
netsh wlan set hostednetwork ssid=%wlanname%
set /p password="请输入wifi密码："
netsh wlan set hostednetwork key=%password%
netsh wlan start hostednetwork
echo *********wifi设置成功，wifi名为%wlanname%, 密码为%password%
pause
goto begin
:open
netsh wlan start hostednetwork
echo *********wifi已开启
pause
goto begin
:close
netsh wlan stop hostednetwork
echo *********wifi已关闭
pause
goto begin
:error
echo 未知错误请重试!
pause
goto begin
:exit
exit
pause