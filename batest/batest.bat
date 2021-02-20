@echo off
setlocal

goto :main

:run_tests <-- %~1: new_path %~2: original_path %~3: testreportfilename %~4: inputarg 1 from batest
setlocal enabledelayedexpansion
	set tempfile=__testfiles__.txt
	set outputfile=__testoutput__.txt
	set "new_path=%~1"
	set /a numberfailed=0
	set /a numberpassed=0
	cd "%~1"
	if exist tests (
		cd tests
		dir /b *_test.bat >../%tempfile%
		cd ..

		if "%~4" NEQ "list" (if exist tests/setup.bat call tests/setup.bat)
			

		for /f "delims=," %%f in (%tempfile%) do (
			if "%~4" == "list" (
				::echo out full filepath
				echo %%~dpnxf
			)else (
				set errorlevel=0
				call tests/%%f >%outputfile%
				if "!errorlevel!" == "0" (
					set status=Passed
					set /a numberpassed+=1
				)else (
					set status=Failed
					set /a numberfailed+=1
				)
				echo ^<tr class=testresult^> ^<td^>%%f^</td^> ^<td class=!status!^>!status!^</td^> >>"%~2/%~3"
				echo ^<td class=output^> >>"%~2/%~3"
				for /f "delims=" %%c in (%outputfile%) do (
					echo %%c >>"%~2/%~3"
				)
				del %outputfile%
				echo ^</td^> >>"%~2/%~3"
				echo ^<td^>%new_path%^</td^> >>"%~2/%~3"
				echo ^</tr^> >>"%~2/%~3"
			)
		)
		del %tempfile%
		
		if "%~4" NEQ "list" (if exist tests/teardown.bat call tests/teardown.bat)
	)
	cd "%~2"
endlocal & set /a numberpassed=%numberpassed% & set /a numberfailed=%numberfailed%
exit /b

:main
set "path=%path%;%~dp0"
set testreport=test_report.html
set css=styles.css
set batestpath=%~dp0

if "%~1" == "-n" (
	set css=night.css
	shift
)

if "%~1" == "--night" (
	set css=night.css
	shift
)

if exist "%~1" (
	set "test_path=%~1"
)else (
	set "test_path=%cd%"
)
cd %test_path%
set "test_path=%cd%"

echo ^<!DOCTYPE html^> >"%test_path%/%testreport%"
echo ^<head^> ^<meta charset="utf-8"^> ^<link rel="stylesheet" href="%batestpath%/css/%css%"^> ^</head^> >>"%test_path%/%testreport%"
echo ^<h2^>Batest report for %test_path%^</h2^> >>"%test_path%/%testreport%"
echo ^<p^>^<i^>%date% %time% %computername%:%username%^</i^>^</p^> >>"%test_path%/%testreport%temp"
echo ^<table^> ^<tr^> ^<th^>Testfile^</th^> ^<th^>Status^</th^> ^<th^>Output^</th^> ^<th^>Path^</th^> ^</tr^> >>"%test_path%/%testreport%temp"

::help input argument
if "%~1" == "help" (
	echo.
	echo Batest runs all bat files ending with "_test" in the specified dir.
	echo.
	echo normal usage: batest ^<test_path^>
	echo.
	echo help               outputs help on all batest options
	echo list ^<test_path^>   outputs all test files recognized by batest in the test_path
	echo path               outputs the directory in which the batest file resides
	echo.
	echo.
	echo Note that Batest does not change the PATH environment variable. As it changes
	echo directory to each test file before running it, the test file must be present
	echo in the same directory as the tested files.
	echo.
	exit /b 0
)

::path input argument
if "%~1" == "path" (
	echo Batest path: %~dp0
	exit /b 0
)

set /a npass=0
set /a nfail=0

::testing scripts
call :run_tests "." "%test_path%" "%testreport%temp" "%~1"

set /a npass+=%numberpassed%
set /a nfail+=%numberfailed%

setlocal enabledelayedexpansion
for /f "delims=," %%c in ('dir /b /s "%test_path%"') do (
	if exist %%~sc\nul (
		call :run_tests "%%c" "%test_path%" "%testreport%temp" "%~1"
		set /a npass+=!numberpassed!
		set /a nfail+=!numberfailed!
	)
)

echo ^<div class=results^>^<p^>^<span class=passedtext^>Passed: %npass%^</span^> ^<span class=failedtext^>Failed: %nfail% ^</span^>^</p^>^</div^> >>"%test_path%/%testreport%"

if exist "%test_path%/%testreport%temp" (
	for /f "tokens=* delims=; usebackq" %%c in ("%test_path%/%testreport%temp") do (
		echo %%c>>"%test_path%/%testreport%"
	)
	del %testreport%temp
)

echo ^</table^> >>"%test_path%/%testreport%"
exit /b 0
