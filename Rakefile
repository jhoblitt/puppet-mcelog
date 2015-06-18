require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet-lint/tasks/puppet-lint'

begin
  require 'puppet_blacksmith/rake_tasks'
rescue LoadError
end

PuppetSyntax.exclude_paths = ['spec/fixtures/**/*']
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"
#PuppetLint.configuration.send('disable_variable_scope')
PuppetLint.configuration.ignore_paths = ['pkg/**/*.pp', 'spec/**/*.pp', 'tests/**/*.pp']

PuppetLint::RakeTask.new :lint do |config|
  config.pattern          = 'manifests/**/*.pp'
  config.fail_on_warnings = true
end

task :travis_lint do
  sh "travis-lint"
end

task :default => [
  :validate,
  :lint,
  :spec,
]
