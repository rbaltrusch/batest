@echo off

if /i "%~1" == "NOT" (
	set not=NOT
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

if /i "%~1" == "EXIST" (
	set first=EXIST
	set message=%~3
	set third=
) else (
	set first="%~1"
)

if %not% %first% %~2 %third% (
	set errorlevel=0
)else (
	set errorlevel=1
	if "%message%" NEQ = "" echo %message%
)
exit /b %errorlevel%
