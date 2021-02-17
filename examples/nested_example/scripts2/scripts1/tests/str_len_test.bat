@echo off

::We call the script get_str_len, which writes the variable str_len to the global scope.
::Note that we are calling get_str_len without specifying a relative directory, even though the two scripts
::are not in the same directory. This is because batest runs all tests in the tests folder from the
::parent folder and calls the tests using relative paths, e.g. call tests/str_len_test
call get_str_len "test"

::Here we assert that the string length returned by the script is actually 4 for the word "test" (should pass)
call assert %str_len% EQU 4 "This is my error message in case the assert fails"

::Exit the script propagating the errorlevel of assert (errorlevel 0 if it passes, 1 if it fails)
exit /b %ERRORLEVEL%
