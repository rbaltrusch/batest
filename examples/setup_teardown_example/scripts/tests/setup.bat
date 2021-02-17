@echo off

::If a setup.bat file is found by batest, it is run before any tests.

::Here, we setup a simple text file containing "this is a test".
::Both the variable my_filename and my_str will be available in other test scripts.
::Note that if the variables are overwritten or deleted in one test, they are not available for the next test!
set my_filename=test.txt
set my_str="this is a test"
echo %my_str%>%my_filename%
