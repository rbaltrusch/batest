# Batest

Batest is a lightweight batchfile unit testing framework, shipping with an [assert](https://github.com/rbaltrusch/batest/tree/master/README.md/#assertions) statement to make testing batchfiles easy. It generates a simple HTML test report containing the results after every run.

![Screenshots of the test reports](https://github.com/rbaltrusch/batest/blob/master/batest/media/screenshot.png?raw=true)

## Getting started

To get a copy of this repository, simply open up git bash in an empty folder and use the command:

		$ git clone https://github.com/rbaltrusch/batest

To call batest from anywhere in the command line, add it to the Windows PATH. Alternatively, navigate to the folder containing the *batest.bat* file to run batest without modifying your Windows PATH.

## How to use

Batest ships with an [assert](https://github.com/rbaltrusch/batest/tree/master/README.md/#assertions) statement (located in the same folder as *batest.bat*), which should be used in the test files you define. Information on the functionality provided with the *assert* statement can be found [here](https://github.com/rbaltrusch/batest/wiki/assert).

To test the current folder with batest, simply run one of the following from the command line:
```batch
batest
batest .
```

To test a specific folder, run one of the following from the command line, either specifying relative or absolute paths:
```batch
batest "../script_folder"
batest "D:/some_folder/script_folder"
```

For more help directly on the command line, run:
```
batest help
```

### Folder structure

The folder containing the scripts to be tested should contain a subfolder called *tests* (as in the example folder structure below).
The *tests* folder must contain all test files that test the scripts under test.

```
+---scripts1
|   \---tests
\---scripts2
    \---tests
```

### Test file naming

All test files must end with the suffix *_test* to be recognized and run by batest.
For example, *some_test.bat* would be recognized and run by batest, but *test_something.bat* would not be.

To list all test files recognized by batest under a path without actually running them, use the *--list [-l]* option, as in the example below:
```batch
batest --list "path/to/folder"
```

### Assertions

The *assert.bat* script shipping with batest supports much of the functionality of the Batch IF statement.

The general syntax for the assert call is:

```batch
call assert operand1 operator operand2 errormessage
```

Some examples of various assert statements and whether they are expected to fail or to pass:

```batch
:: should pass, 1 equals 1
call assert 1 EQU 1 "my message"

::should pass if file.txt exists
call assert exist file.txt "file is missing"

::should pass 1 is not greater than 2
call assert NOT 1 GEQ 2 "error message"
```

Passing assert statements set ERRORLEVEL to 0, failing ones to 1.

More help is available in the [wiki](https://github.com/rbaltrusch/batest/wiki/assert) or directly in the command line:

	assert help


### More information

For more information on the use of batest, assert, and the folder structure, please have a look at the [examples](https://github.com/rbaltrusch/batest/tree/master/examples) and the [wiki](https://github.com/rbaltrusch/batest/wiki).

## Contributions

Any contributions, such as additional features, bugfixes, or documentation are much appreciated. Contribution guidelines are specified in [CONTRIBUTING.md](https://github.com/rbaltrusch/batest/blob/master/CONTRIBUTING.md).

## License

This repository is open-source software available under the [MIT license](https://github.com/rbaltrusch/batest/blob/master/LICENSE).

## Contact

Please raise an issue for code changes. To reach out, please send an email to richard@baltrusch.net.
