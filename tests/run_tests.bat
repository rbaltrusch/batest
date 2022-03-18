::runs batest.bat in the batest folder. Used for a Github Actions Workflow.
@ call "../batest/batest.bat" -v ../batest
@ exit /b %ERRORLEVEL%
