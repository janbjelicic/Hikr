fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios cleanup
```
fastlane ios cleanup
```
Clears derived data, any locally-built archives, and resets simulators
### ios changelog
```
fastlane ios changelog
```
Update changelog
### ios test
```
fastlane ios test
```
Generate Unit Test Code Coverage
### ios distribute
```
fastlane ios distribute
```
Push a new build to Testflight
### ios set_dsyms
```
fastlane ios set_dsyms
```
Usage: fastlane set_dsyms version:1.2.3 build:1234

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
