# Simple example

This example provides one script, *scripts/get_str_len.bat*, and one test, *scripts/tests/str_len_test.bat*,
which tests whether the script returns the correct string length for a given string.

## Folder structure

Note that the tests are (and must be) in a subfolder to the scripts folder. The folder containing the tests **must** be named *tests*.
The name of any test batchfile placed within the *tests* folder must end with the suffix *_test*. For example, *my_test.bat*
is a valid test filename and will be recognized and run by batest, while *test_my_functionality.bat* will not be.

## How to run

To run this test, run:

	batest <path_to_scripts_folder>

If batest is being run from within its own folder, we can specify the following relative path:

	batest "..examples/simple_example"

## Test report

The test report *test_report.html* will be generated under the path specified when running batest.

## Path modifications

Batest does not change your Windows PATH variable. It merely switches to all folders containing a *tests* subdirectory and then runs all test files found in that *tests* directory.

## More information

More information is available in the [other examples](https://github.com/rbaltrusch/batest/examples) and the [wiki](https://github.com/rbaltrusch/batest/wiki).
