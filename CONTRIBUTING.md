# Contribution guidelines

First of all, thank you for considering to contribute to this repository! Any contributions are welcome and will be considered for merges to this repository.

Before submitting your contribution, there are a few things to review, which are detailed below:
- [Scope of the repository](https://github.com/rbaltrusch/batest/blob/master/CONTRIBUTING.md/#scope-of-the-repository)
- [Bugfixes and corrections](https://github.com/rbaltrusch/batest/blob/master/CONTRIBUTING.md/#bugfixes-and-corrections)
- [New content](https://github.com/rbaltrusch/batest/blob/master/CONTRIBUTING.md/#new-content)

After a timely review of a pull request by the maintainers of this repository, the pull request may be merged in to the master branch of this repository if it passes the review, otherwise appropriate review comments will be provided on the pull request. Once the review comments are addressed, the pull request may be merged in as normal.

## Scope of the repository

Batest is a lightweight testing framework for batchfiles and should remain lightweight where possible. Functionality that can already be achieved using batest should not be reimplemented in a different form, unless the new functionality is significantly more convenient to use.

As Batch is an old language with little active development beyond maintenance of existing scripts, it makes little sense to turn batest into a more complex testing framework on par with more modern languages, such as Python or Java.

The main features provided by batest are:
- Functionality to assert a condition has been met.
- Functionality to provide information on failed assertions, such as an assertion error message and the console output of the failed test or script under test.
- Functionality that groups all test results in a simple test report.

## Bugfixes and corrections

Bugfixes to the documentation or functionality provided by batest should contain a clear description of the bug (when and why it occurs) and contain working code that addresses the described problem. If the bug was described in an [issue](https://github.com/rbaltrusch/batest/issues), please link the bugfix pull request to the corresponding issue in the title or description of the pull request.

## Pull requests

Before submitting a pull request, please review the [pull request guidelines](.github/pull_request_template.md).

## New content

New content, such as new features or more documentation, is also very much appreciated and welcome to this repository, as long as it stays within the [scope of the repository](https://github.com/rbaltrusch/batest/blob/master/CONTRIBUTING.md/#scope-of-the-repository). A clear description of the new content must be provided with the pull request, including information on what the new content includes and why it is a fitting addition to the repository.

### New features
Code must be working, clear, concise and commented.

Pull requests containing new features **must** link to a corresponding [feature request](https://github.com/rbaltrusch/batest/issues).

### Documentation
Additional documentation, including new wiki pages, tutorials, and more examples, should be clear and concise, provide examples, and link to existing documentation where possible.

## Contact

For any question that remains unclear after reading these guidelines, please raise an [issue](https://github.com/rbaltrusch/batest/issues) describing the unclear or lacking content.
