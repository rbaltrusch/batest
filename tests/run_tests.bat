@echo off
::runs batest.bat in the batest folder. Used for a Github Actions Workflow.
::Note that batest does not and cannot return errorlevel if a test failed (windows bug)
::Instead, this is solved by echoing out the number of failed tests and redirecting this.

set ERRORLEVEL=0
set tempfile=__temp__
call "../batest/batest.bat" ../batest > %tempfile%
set /p ERRORLEVEL= < %tempfile%
del %tempfile%
echo %ERRORLEVEL% error(s) occured.
exit /b %ERRORLEVEL%
