@echo off

::We are asserting that the strings test and quest are the same. This will fail and output the error message:
::"Expected test, but got quest"
call assert "test" EQU "quest" "Expected test, but got quest"

::Exit the script propagating the errorlevel of assert (errorlevel 0 if it passes, 1 if it fails)
exit /b %ERRORLEVEL%
