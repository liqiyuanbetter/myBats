@echo off & setlocal enabledelayedexpansion
title �˿ڼ��ͽ��̴��� @author liqiyuan
:start
echo.
echo.
set /p port="������Ҫ���Ķ˿ںţ�����#�ż���������"
if !port!==# (
	goto end
) else (
rem ����
rem netstat -ano -p tcp | find "%port%">nul && echo �˿�%port%�ѱ�ռ�� || echo �˿�%port%δ��ռ��

	for /f "tokens=5" %%i in ('netstat -ano -p tcp ^| findstr /c:":%port% "') do (
		set pid=%%i
		rem pid�������һֱ���ڣ���˻���Ҫһ����־���ж��Ƿ���֮ǰ�����
		set flag=true
	)
	rem ֻ�е�pid���������Ҳ���֮ǰ����Ĳ�˵���ö˿ڱ�ռ����
	if defined pid (
		if !flag!==true (
			rem �������
			call :process
			set flag=false;
			goto start
		)
	)
	
	echo   *****************************************************************
	echo   *     !port!�˿�δ��ռ��!     
	echo   *****************************************************************
	goto start
)
:end
exit
:process
for /f %%i in ('tasklist ^| findstr /c:" !pid! "') do (
	set pName=%%i
	echo   *****************************************************************
	echo   *     ռ�ö˿�--!port!--�Ľ���id��--!pid!, ��������--%%i     
	echo   *****************************************************************
	choice /c:yn /m "�Ƿ�Ҫ��ֹ�ý���"
	if errorlevel 2 goto donothing
	if errorlevel 1 goto kill
)
:kill
	taskkill /f /pid !pid! /t>nul
	echo ����!pName!����ֹ��
:donothing