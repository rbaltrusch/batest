# Tests with setup and teardown

## Folder structure

This example uses the folder structure below. It specifies a *setup.bat* file, which will be run by batest before the test files, and a 
*teardown.bat* file, which will be run by batest after the test files. In this specific example, *setup.bat* writes to a text file and two
variables, both of which will be available for any number of tests that are run after it, and *teardown.bat* deletes the text file.

Note that the setup and teardown files **must** be called *setup.bat* and *teardown.bat* and be placed under the respective tests directory, as below:

```
\---scripts
    |   get_str_len.bat
    |   
    \---tests
            setup.bat
            str_len_test.bat
            teardown.bat
```

Note that *setup* and *teardown* are **not** run after each test, but rather before and after all the tests, i.e. they are called in the following order:
```batch
call setup
call str_len_test
call some_other_test
call teardown
```

## Fixtures

As the variables defined in *setup.bat* are available in the global scope of all test files, *setup.bat* may also be used
to define test fixtures, which will be available for all tests run after it, assuming that no test modifies the contents
of the test fixtures.

Note that it is good practice to deinitialize the contents of the test fixtures in *teardown.bat*, because they may otherwise influence
the results of test files in other tests directory being run after the tests directory which initialized the test fixtures.

## How to run

To run this test, run:

	batest <path_to_scripts_folder>

If batest is being run from within its own folder, we can specify the following relative path:

	batest "..examples/setup_teardown_example"

## More information

For a basic example, please have a look at the [simple example](https://github.com/rbaltrusch/batest/examples/simple_example) first.

More information is available in the [other examples](https://github.com/rbaltrusch/batest/examples) and the [wiki](https://github.com/rbaltrusch/batest/wiki).
