@echo off

:: basic tests
call assert 1 EQU 1 "1 should be equal to 1"

set myvar=1
call assert DEFINED myvar "myvar should be defined 1"
call assert defined myvar "myvar should be defined 2"

echo something>__test__.txt
call assert EXIST __test__.txt "__test__.txt should exist 1"
call assert exist __test__.txt "__test__.txt should exist 2"
del __test__.txt

set ERRORLEVEL=0
call assert ERRORLEVEL 0 "Errorlevel should be 0 or greater 1"

set ERRORLEVEL=0
call assert errorlevel 0 "Errorlevel should be 0 or greater 2"


:: NOT tests
call assert NOT 1 GEQ 2 "1 should not be greater or equal than 2"

set myvar=
call assert NOT DEFINED myvar "myvar should not be defined 1"
call assert not defined myvar "myvar should not be defined 2"

call assert NOT EXIST __test__.txt "__test__.txt should not exist 1"

set ERRORLEVEL=1
call assert NOT ERRORLEVEL 2 "Errorlevel should be less than 2"
