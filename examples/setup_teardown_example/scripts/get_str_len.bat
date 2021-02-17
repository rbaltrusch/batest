@echo off
ECHO %~1> tempfile
::%%~z? is a special expression to get the length of a file
FOR %%? IN (tempfile) DO ( SET /A str_len=%%~z? - 2 )
del tempfile