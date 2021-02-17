@echo off

::We are asserting that 1 equals 0. This will fail and output the error message "1 is not equal 0"
call assert 1 EQU 0 "1 is not equal 0"

::Exit the script propagating the errorlevel of assert (errorlevel 0 if it passes, 1 if it fails)
exit /b %ERRORLEVEL%
