@echo off

if /i "%~1" == "NOT" (
	set not=%~1
	shift
) else (
	set not=
)

set operator=%~2
set message=%~4

if "%~3" == "" (
	set third=
) else (
	set third="%~3"
)

set first="%~1"

if /i "%~1" == "EXIST" (
	set first=%~1
	set message=%~3
	set third=
)

if /i "%~1" == "ERRORLEVEL" (
	set first=%~1
	set message=%~3
	set third=
)

echo %not% %first% %~2 %third%
if %not% %first% %~2 %third% (
	set errorlevel=0
)else (
	set errorlevel=1
	if "%message%" NEQ = "" echo %message%
)
exit /b %errorlevel%
