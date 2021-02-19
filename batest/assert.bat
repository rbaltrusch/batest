@echo off

if /i "%~1" == "help" (
	echo The assert statement that assert.bat provides can be used to assert that certain conditions are true.
	echo.
	echo General usage: CALL assert OPERAND1 OPERATOR OPERAND1 MESSAGE
	echo.
	echo If the assertion passes, ERRORLEVEL is set to 0. If it fails, it is set to 1 and the error message provided, if any, is outputted to console.
	echo.
	echo The assert statement supports a lot of the functionality that the IF statement supports. In particular, it supports the following operators:
	echo.
	echo     ==
	echo     EQU
	echo     NEQ
	echo     GEQ
	echo     LSS
	echo     GTR
	echo     NOT
	echo     EXIST
	echo.
	echo For more help regarding the operators, see HELP IF.
	echo.
	pause
	echo.
	echo Examples:
	echo.
	echo     call assert 1 EQU 1 "This is the error message"
	echo     call assert EXIST file.txt
	echo     call assert NOT 1 GEQ 2
	echo.
	exit /b 0
)

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

if %not% %first% %~2 %third% (
	set errorlevel=0
)else (
	set errorlevel=1
	if "%message%" NEQ = "" echo %message%
)
exit /b %errorlevel%
