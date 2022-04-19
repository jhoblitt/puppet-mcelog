# Puppet mcelog Module

## Table of Contents

1. [Overview](#overview)
1. [Description](#description)
1. [Usage](#usage)
  * [Simple](#simple)
  * [`mcelog`](#mcelog)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations](#limitations)
  * [Tested Platforms](#tested-platforms)
  * [Puppet Version Compatibility](#puppet-version-compatibility)
1. [Versioning](#versioning)
1. [Support](#support)
1. [Contributing](#contributing)
1. [See Also](#see-also)

## Overview

Manages the `mcelog` utility for x86-64 CPU Machine Check Exception data

## Description

This is a puppet module for the installation and configuration of the
[`mcelog`](http://www.mcelog.org/) utility.  Which can be used either from the
cli or run as a daemon that extracts and decodes [Machine Check Exception
(MCE)](https://en.wikipedia.org/wiki/Machine-check_exception) data.

## Usage

### Simple

```puppet
include ::mcelog
```

### `mcelog`

This class is presently the only public API in this module.

```puppet
# defaults
class { '::mcelog':
  config_file_template => 'mcelog/mcelog.conf.erb',
}
```

## Reference

See [REFERENCE](REFERENCE.md).

## Limitations

This module is extremely basic. A few obvious improvements would be to:

* provide more configuration options; specifically enable/disable mce events being sent to syslog
* logrotated setup of the mcelog log file
* provide support for running mcelog as a daemon on EL5.x

Please note that MCE is only avaiable on `x86_64`. It /can not/ work and the
package is likely not avaible on `i386` hosts.

## Versioning

This module is versioned according to the [Semantic Versioning
2.0.0](http://semver.org/spec/v2.0.0.html) specification.

## Support

Please log tickets and issues at
[github](https://github.com/jhoblitt/puppet-mcelog/issues)

## Contributing

1. Fork it on github
1. Make a local clone of your fork
1. Create a topic branch.  Eg, `feature/mousetrap`
1. Make/commit changes
  * Commit messages should be in [imperative tense](http://git-scm.com/book/ch5-2.html)
  * Check that linter warnings or errors are not introduced - `bundle exec rake lint`
  * Check that `Rspec-puppet` unit tests are not broken and coverage is added for new
    features - `bundle exec rake spec`
  * Documentation of API/features is updated as appropriate in the README
  * If present, `beaker` acceptance tests should be run and potentially
    updated - `bundle exec rake beaker`
1. When the feature is complete, rebase / squash the branch history as
   necessary to remove "fix typo", "oops", "whitespace" and other trivial commits
1. Push the topic branch to github
1. Open a Pull Request (PR) from the *topic branch* onto parent repo's `master` branch

## See Also

* [mcelog](http://www.mcelog.org/)
* [Machine Check Exception (MCE)](https://en.wikipedia.org/wiki/Machine-check_exception)
