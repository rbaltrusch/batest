@echo off

::If a teardown.bat file is found by batest, it is run after any tests.

::Here, we delete the tempfile that was written to by setup.bat
if exist "%my_filename%" del "%my_filename%"

::delete variables after running tests
set my_filename=
set my_str=
