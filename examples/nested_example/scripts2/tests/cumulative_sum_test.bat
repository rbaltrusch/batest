@echo off

::We call the script get_cumulative_sum, which writes the variable cumulative_sum to the global scope.
::Note that we are calling get_cumulative_sum without specifying a relative directory, even though the two scripts
::are not in the same directory. This is because batest runs all tests in the tests folder from the
::parent folder and calls the tests using relative paths, e.g. call tests/cumulative_sum_test
call get_cumulative_sum 1 1 5

::We assert that the returned cumulative_sum is equal to 15 and output the following message if it fails:
::"Expected sum of numbers 1 to 5 to equal 15!"
call assert %cumulative_sum% EQU 15 "Expected sum of numbers 1 to 5 to equal 15!"

::Exit the script propagating the errorlevel of assert (errorlevel 0 if it passes, 1 if it fails)
exit /b %ERRORLEVEL%
