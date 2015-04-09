# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'increment_with_sql/version'

Gem::Specification.new do |spec|
  spec.name          = "increment_with_sql"
  spec.version       = IncrementWithSql::VERSION
  spec.authors       = ["Benjamin Vetter"]
  spec.email         = ["vetter@plainpicture.de"]
  spec.summary       = %q{Provides increment_with_sql! and decrement_with_sql! for ActiveRecord models}
  spec.description   = %q{Provides increment_with_sql! and decrement_with_sql! for ActiveRecord models}
  spec.homepage      = "https://github.com/mrkamel/increment_with_sql"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "activerecord", ">= 3.0.0"
  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "minitest"
end

