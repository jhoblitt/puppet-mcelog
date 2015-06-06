Puppet mcelog Module
====================

[![Build Status](https://travis-ci.org/jhoblitt/puppet-mcelog.png)](https://travis-ci.org/jhoblitt/puppet-mcelog)

#### Table of Contents

1. [Overview](#overview)
2. [Description](#description)
3. [Usage](#usage)
    * [Simple](#simple)
    * [`mcelog`](#mcelog)
4. [Limitations](#limitations)
    * [Tested Platforms](#tested-platforms)
5. [Versioning](#versioning)
6. [Support](#support)
7. [Contributing](#contributing)
8. [See Also](#see-also)


Overview
--------

Manages the `mcelog` utility for x86-64 CPU Machine Check Exception data


Description
-----------

This is a puppet module for the installation and configuration of the
[`mcelog`](http://www.mcelog.org/) utility.  Which can be used either from the
cli or run as a daemon that extracts and decodes [Machine Check Exception
(MCE)](https://en.wikipedia.org/wiki/Machine-check_exception) data.

Usage
-----

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

* `config_file_template`

`String` defaults to: `mcelog/mcelog.conf.erb`

The name of the [ERB] template to use for the generation of the `mcelog.conf`
file.


Limitations
-----------

This module is extremely basic. A few obvious improvements would be to:

* provide more configuration options; specifically enable/disable mce events being sent to syslog
* logrotated setup of the mcelog log file
* provide support for running mcelog as a daemon on EL5.x

Please note that MCE is only avaiable on `x86_64`. It /can not/ work and the
package is likely not avaible on `i386` hosts.

### Tested Platforms

* EL5.x
* EL6.x

Versioning
----------

This module is versioned according to the [Semantic Versioning
2.0.0](http://semver.org/spec/v2.0.0.html) specification.


Support
-------

Please log tickets and issues at
[github](https://github.com/jhoblitt/puppet-mcelog/issues)


Contributing
------------

1. Fork it on github
2. Make a local clone of your fork
3. Create a topic branch.  Eg, `feature/mousetrap`
4. Make/commit changes
    * Commit messages should be in [imperative tense](http://git-scm.com/book/ch5-2.html)
    * Check that linter warnings or errors are not introduced - `bundle exec rake lint`
    * Check that `Rspec-puppet` unit tests are not broken and coverage is added for new
      features - `bundle exec rake spec`
    * Documentation of API/features is updated as appropriate in the README
    * If present, `beaker` acceptance tests should be run and potentially
      updated - `bundle exec rake beaker`
5. When the feature is complete, rebase / squash the branch history as
   necessary to remove "fix typo", "oops", "whitespace" and other trivial commits
6. Push the topic branch to github
7. Open a Pull Request (PR) from the *topic branch* onto parent repo's `master` branch


See Also
--------

* [mcelog](http://www.mcelog.org/)
* [Machine Check Exception (MCE)](https://en.wikipedia.org/wiki/Machine-check_exception)
