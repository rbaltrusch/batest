@echo off

::We read in the contents of the file written by setup.bat and access the name provided from setup and
:: store it in the variable filecontents.
set /p filecontents= <%my_filename%

::We call the script get_str_len, which writes the variable str_len to the global scope.
::Note that we are calling get_str_len without specifying a relative directory, even though the two scripts
::are not in the same directory. This is because batest runs all tests in the tests folder from the
::parent folder and calls the tests using relative paths, e.g. call tests/str_len_test
call get_str_len %filecontents%

::Here we assert that the string length returned by the script is actually 14 for the filecontents that
::were written by setup.bat (should be "this is a test", with length 14) --> should pass.
call assert %str_len% EQU 14 "This is my error message in case the assert fails"

::Exit the script propagating the errorlevel of assert (errorlevel 0 if it passes, 1 if it fails)
exit /b %ERRORLEVEL%
