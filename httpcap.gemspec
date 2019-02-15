# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'httpcap/version'

Gem::Specification.new do |spec|
  spec.name          = 'httpcap-rb'
  spec.version       = HTTPcap::VERSION
  spec.authors       = ['naari3']
  spec.email         = ['naari.named@gmail.com']

  spec.summary       = 'parse pcap, then return http request and response'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/naari3/httpcap'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'http-parser-lite'
  spec.add_dependency 'reassemble_tcp'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
