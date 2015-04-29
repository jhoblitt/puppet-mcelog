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
    * [Puppet Version Compatibility](#puppet-version-compatibility)
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

* `package_name`

`String` defaults to: `mcelog`

The name of the package.

* `config_file_path`

`String` defaults to: `/etc/mcelog.conf` on EL5 or `/etc/mcelog/mcelog.conf` on EL6 and EL7

The path of mcelog configuration file.

* `config_file_template`

`String` defaults to: `mcelog/mcelog.conf.erb`

The name of the [ERB] template to use for the generation of the `mcelog.conf`
file.

* `service_name`

`String` defaults to: `mcelogd` on EL6 or `mcelog` on EL7

The name of the service.

* `service_stdout`

`String` defaults to: `null`

Only for EL7. The value of the StandardOutput parameter in the systemd script.


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
* EL7.x
* Fedora 22

### Puppet Version Compatibility

Versions | Puppet 2.7 | Puppet 3.x | Puppet 4.x
:--------|:----------:|:----------:|:----------:
**0.x**  | **yes**    | **yes**    | no
**1.x**  | no         | **yes**    | **yes**


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
