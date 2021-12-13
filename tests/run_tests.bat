@echo off
set ERRORLEVEL=0
set tempfile=__temp__
call "../batest/batest.bat" ../batest > %tempfile%
set /p ERRORLEVEL= < %tempfile%
del %tempfile%
echo %ERRORLEVEL%
exit /b %ERRORLEVEL%
