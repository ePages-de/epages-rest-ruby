# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'epages/version'

Gem::Specification.new do |spec|
  spec.version       = Epages::VERSION
  spec.name          = 'epages'
  spec.authors       = ['Domingo Cividanes']
  spec.email         = ['dcividanes91@gmail.com']
  spec.description   = 'A Ruby interface to the Epages Rest API.'
  spec.summary       = spec.description
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = 'MIT'

  spec.require_paths = %w(lib)
  spec.files         = %w(LICENSE.txt README.md epages.gemspec) + Dir['lib/**/*.rb']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'http', '~> 0.9.4'
  spec.add_dependency 'http-form_data', '~> 1.0'
  spec.add_dependency 'http_parser.rb', '~> 0.6.0'
end
