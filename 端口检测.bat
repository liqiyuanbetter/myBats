@echo off & setlocal enabledelayedexpansion
title 端口检测和进程处理 @author liqiyuan
:start
echo.
echo.
set /p port="输入需要检测的端口号，输入#号键结束程序："
if !port!==# (
	goto end
) else (
rem 弃用
rem netstat -ano -p tcp | find "%port%">nul && echo 端口%port%已被占用 || echo 端口%port%未被占用

	for /f "tokens=5" %%i in ('netstat -ano -p tcp ^| findstr /c:":%port% "') do (
		set pid=%%i
		rem pid被定义后一直存在，因此还需要一个标志来判断是否是之前定义的
		set flag=true
	)
	rem 只有当pid被定义了且不是之前定义的才说明该端口被占用了
	if defined pid (
		if !flag!==true (
			rem 处理进程
			call :process
			set flag=false;
			goto start
		)
	)
	
	echo   *****************************************************************
	echo   *     !port!端口未被占用!     
	echo   *****************************************************************
	goto start
)
:end
exit
:process
for /f %%i in ('tasklist ^| findstr /c:" !pid! "') do (
	set pName=%%i
	echo   *****************************************************************
	echo   *     占用端口--!port!--的进程id是--!pid!, 进程名是--%%i     
	echo   *****************************************************************
	choice /c:yn /m "是否要终止该进程"
	if errorlevel 2 goto donothing
	if errorlevel 1 goto kill
)
:kill
	taskkill /f /pid !pid! /t>nul
	echo 进程!pName!已终止！
:donothing