@echo off

:: This script takes one input argument and determines the length of it as a string and writes the result back into the
::global scope under the variable str_len

ECHO %~1> tempfile
::%%~z? is a special expression to get the length of a file
FOR %%? IN (tempfile) DO ( SET /A str_len=%%~z? - 2 )
del tempfile
