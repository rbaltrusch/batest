@echo off
if "%~1" %~2 "%~3" (
	set errorlevel=0
)else (
	set errorlevel=1
	if "%~4" NEQ = "" echo %~4
)
exit /b %errorlevel%
