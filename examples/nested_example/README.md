# Nested folder under test

## Folder structure

The example provided uses the folder structure shown below, with two separate scripts folders, each containing their own tests directory. Batest is able to recognize both tests folders and run the test files in them.
```
+---scripts1
|   \---tests
\---scripts2
    \---tests
```

Although not showcased in this example, batest is able to test arbitrarily deeply nested structures.
For example, batest would be able to recognize and execute all tests folders specified in the following folder structure:
```
+---scripts1
|   \---tests
\---scripts2
    +---scripts1
    |   \---tests
    +---scripts2
    |   \---tests
    \---tests
```

## How to run

To run this test, run:

	batest <path_to_scripts_folder>

If batest is being run from within its own folder, we can specify the following relative path:

	batest "..examples/nested_example"

## More information

For a basic example, please have a look at the [simple example](https://github.com/rbaltrusch/batest/examples/simple_example) first.

More information is available in the [other examples](https://github.com/rbaltrusch/batest/examples) and the [wiki](https://github.com/rbaltrusch/batest/wiki).
