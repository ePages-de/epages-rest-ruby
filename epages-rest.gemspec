# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'epages/version'

Gem::Specification.new do |spec|
  spec.version       = Epages::VERSION
  spec.name          = 'epages-rest'
  spec.authors       = ['Domingo Cividanes', 'Unai Martinez']
  spec.email         = ['u.martinez@epages.com']
  spec.description   = 'A Ruby interface that allows to integrate any Epages Shop with any ruby framework via Epages Rest API.'
  spec.summary       = 'A Ruby interface to the Epages Rest API.'
  spec.homepage      = 'https://github.com/ePages-de/epages-rest-ruby'
  spec.license       = 'MIT'

  spec.require_paths = %w(lib)
  spec.files         = %w(LICENSE.txt README.md epages-rest.gemspec) + Dir['lib/**/*.rb']

  spec.add_development_dependency 'bundler', '~> 2.5'
  spec.add_dependency 'http', '~> 2.1'
  spec.add_dependency 'activesupport', '~> 5.0'
end
