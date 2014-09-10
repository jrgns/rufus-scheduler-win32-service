# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rufus/scheduler/win32/service/version'

Gem::Specification.new do |spec|
  spec.name          = 'rufus-scheduler-win32-service'
  spec.version       = Rufus::Scheduler::Win32::Service::VERSION
  spec.authors       = ['Jurgens du Toit']
  spec.email         = ['jrgns@jadeit.co.za']
  spec.description   = %(
    A simple wrapper around the rufus-cheduler to run it as a Windows Service'
  ).strip
  spec.summary       = %(
    A simple wrapper around the rufus-cheduler to run it as a Windows Service
  ).strip
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rufus-scheduler'
  spec.add_runtime_dependency 'win32-service'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec', '~> 2.6'

end
