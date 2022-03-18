::verbose mode
@echo off
@if "%~1" == "-v" (
	@shift
	set verbose=true
) else (
	set verbose=false
)

::setlocal required to keep changes to current directory in the local scope
setlocal

goto :main

This is the main batest script. To receive more information, run batest help or visit:
https://github.com/rbaltrusch/batest

:run_tests <-- %~1: new_path %~2: original_path %~3: testreportfilename %~4: inputarg 1 from batest
setlocal enabledelayedexpansion
	::variables setup
	set tempfile=__testfiles__.txt
	set outputfile=__testoutput__.txt
	set "new_path=%~1"
	set /a numberfailed=0
	set /a numberpassed=0

	cd "%~1"
	if exist tests (

		::get contents of tests folder
		cd tests
		dir /b *_test.bat >../%tempfile%
		cd ..

		::setup.bat
		if "%~4" NEQ "list" (if exist tests/setup.bat call tests/setup.bat)
			

		::loop through test files and run them normally, or echo path for "batest list"
		for /f "delims=," %%f in (%tempfile%) do (
			if "%~4" == "list" (
				::echo out full filepath
				echo %%~dpnxf
			)else (
			if "%%f" NEQ "" (
				set errorlevel=0
				if "%verbose%" == "true" ( echo Running test file "tests/%%f" )
				call "tests/%%f" >%outputfile%
				if "!errorlevel!" == "0" (
					set status=Passed
					set /a numberpassed+=1
					if "%verbose%" == "true" ( echo Test passed. )
				)else (
					set status=Failed
					set /a numberfailed+=1
					if "%verbose%" == "true" ( echo Test failed^^! )
				)

				::html table rows
				echo ^<tr class=testresult^> ^<td^>%%f^</td^> ^<td class=!status!^>!status!^</td^> >>"%~2/%~3"
				echo ^<td class=output^> >>"%~2/%~3"

				::extract console log from function call
				for /f "delims=" %%c in (%outputfile%) do (
					echo %%c >>"%~2/%~3"
				)
				del %outputfile%

				::html filepath col 
				echo ^</td^> >>"%~2/%~3"
				echo ^<td^>%~dpf1^</td^> >>"%~2/%~3"
				echo ^</tr^> >>"%~2/%~3"
			)
			)
		)
		del %tempfile%
		
		::teardown.bat
		if "%~4" NEQ "list" (if exist tests/teardown.bat call tests/teardown.bat)
	)
	cd "%~2"
endlocal & set /a numberpassed=%numberpassed% & set /a numberfailed=%numberfailed%
exit /b

:main
rem variables setup
set testreport=test_report.html
set css=styles.css
set batestpath=%~dp0
set list=

::add batest to path (not permanently)
if "%verbose%" == "true" (
	echo Batest path: %batestpath%
	echo Temporarily adding batest to path...
)
set "path=%path%;%~dp0"

::night mode
if "%~1" == "-n" (
	set css=night.css
	shift
)

::night mode
if "%~1" == "--night" (
	set css=night.css
	shift
)

::list dir
if "%~1" == "--list" (
	set list=list
	shift
)

::list dir
if "%~1" == "-l" (
	set list=list
	shift
)

::help input argument
if "%~1" == "help" (
	echo.
	echo Batest runs all bat files ending with "_test" in the specified dir.
	echo.
	echo normal usage: batest ^<test_path^>
	echo    dark mode: batest --night [-n] ^<test_path^>
	echo.
	echo help                     outputs help on all batest options
	echo path                     outputs the directory in which the batest file resides
	echo -v                       switches on verbose mode ^(needs to be first argument^)
	echo --list [-l] ^<test_path^>  list all test files recognized under test_path
	echo.
	echo.
	echo.
	echo Note that Batest does not add the test directories to the PATH environment variable. As it changes directory to each test file before running it, the test file must be present in a tests subdirectory.
	echo.
	exit /b 0
)

::path input argument
if "%~1" == "path" (
	echo Batest path: %~dp0
	exit /b 0
)

::specified test path
if exist "%~1" (
	set "test_path=%~1"
	if "%verbose%" == "true" ( echo Set test path to "%test_path%" )
)else (
	echo The specified test path "%~1" does not exist!
	exit /b 1
)
cd %test_path%
set "test_path=%cd%"


::test report header
::-------------------------------
echo ^<!DOCTYPE html^> >"%test_path%/%testreport%"
echo ^<head^> ^<meta charset="utf-8"^> ^<style^> >>"%test_path%/%testreport%"

::inline css
pushd "%batestpath%/css"
type %css% >>"%test_path%/%testreport%"
popd
echo ^</style^> ^</head^> >>"%test_path%/%testreport%"

echo ^<h2^>Batest report for %test_path%^</h2^> >>"%test_path%/%testreport%"
echo ^<p^>^<i^>%date% %time% %computername%:%username%^</i^>^</p^> >>"%test_path%/%testreport%temp"
echo ^<table^> ^<tr^> ^<th^>Testfile^</th^> ^<th^>Status^</th^> ^<th^>Output^</th^> ^<th^>Path^</th^> ^</tr^> >>"%test_path%/%testreport%temp"
::-------------------------------

set /a npass=0
set /a nfail=0

::testing scripts
if "%verbose%" == "true" ( echo Recursively running all tests in folder "%test_path%" )
if "%verbose%" == "true" ( echo Running tests for folder "%cd%" )
call :run_tests "." "%test_path%" "%testreport%temp" "%list%"

set /a npass+=%numberpassed%
set /a nfail+=%numberfailed%

setlocal enabledelayedexpansion
for /f "delims=," %%c in ('dir /b /s "%test_path%"') do (
	::check if it is a folder
	if exist %%~sc\nul (
		::test scripts
		if "%verbose%" == "true" ( echo Running tests for subfolder "%%c" )
		call :run_tests "%%c" "%test_path%" "%testreport%temp" "%list%"
		set /a npass+=!numberpassed!
		set /a nfail+=!numberfailed!
	)
)

if "%verbose%" == "true" ( echo Writing test results to "%test_path%/%testreport%" )
if "%verbose%" == "true" ( echo Passed !npass!; Failed !nfail!. )

::Passed and Failed sum titles
echo ^<div class=results^>^<p^>^<span class=passedtext^>Passed: %npass%^</span^> ^<span class=failedtext^>Failed: %nfail% ^</span^>^</p^>^</div^> >>"%test_path%/%testreport%"

::extract test result table out of temp report
if exist "%test_path%/%testreport%temp" (
	for /f "tokens=* delims=; usebackq" %%c in ("%test_path%/%testreport%temp") do (
		echo %%c>>"%test_path%/%testreport%"
	)
	del %testreport%temp
)

::test report footer
echo ^</table^> >>"%test_path%/%testreport%"

endlocal
if "%list%" NEQ "list" ( echo %nfail% )
exit /b 0
