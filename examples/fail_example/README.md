# Failing tests example

## Folder structure

The example provides two tests that assert a condition that will fail:
- tests/false_assert_test.bat
- tests/another_false_assert_test.bat

As all test script output is redirected to the test report, it will contain the failed assertion message for both tests.

## How to run

To run this test, run:

	batest <path_to_scripts_folder>

If batest is being run from within its own folder, we can specify the following relative path:

	batest "..examples/fail_example"

## More information

For a basic example, please have a look at the [simple example](https://github.com/rbaltrusch/batest/examples/simple_example) first.

More information is available in the [other examples](https://github.com/rbaltrusch/batest/examples) and the [wiki](https://github.com/rbaltrusch/batest/wiki).
