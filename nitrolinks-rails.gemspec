# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nitrolinks/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "nitrolinks-rails"
  spec.version       = Nitrolinks::Rails::VERSION
  spec.authors       = ["Wayne Duran"]
  spec.email         = ["asartalo@gmail.com"]

  spec.summary       = "Single-page Apps feel with less overhead"
  spec.description   = "Like Pjax and Turbolinks but with smarter DOM updating"
  spec.homepage      = "https://github.com/asartalo/nitrolinks-rails"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 5.1"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
