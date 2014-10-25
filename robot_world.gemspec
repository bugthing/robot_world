# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'robot_world/version'

Gem::Specification.new do |spec|
  spec.name          = "robot_world"
  spec.version       = RobotWorld::VERSION
  spec.authors       = ["Benjamin Martin"]
  spec.email         = ["benjaminjohnmartin@gmail.com"]
  spec.summary       = %q{Robots on Mars for RedBadger.}
  spec.description   = %q{Gem to statify the coding challenge from RedBadger.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "virtus", "~> 1.0"
  spec.add_dependency "thor", "~> 0.19"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
end
