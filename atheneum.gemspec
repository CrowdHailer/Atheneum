# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'atheneum/version'

Gem::Specification.new do |spec|
  spec.name          = "atheneum"
  spec.version       = Atheneum::VERSION
  spec.authors       = ["Peter"]
  spec.email         = ["peterhsaxton@gmail.com"]
  spec.summary       = %q{A micro gem for the immaculate inclusion of BCrypt protected data for example passwords}
  spec.description   = %q{Simply declare attributes that require obscuring and that will make it so.
                          Useful in exposing buisness logic in objects that use BCrypt
                          This gem currently assumes that BCrypt is available rather than adding it as a dependency,
                          future versions might support general strategies.
                        }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.4.3"
  spec.add_development_dependency "minitest-reporters", "~> 1.0.6"
end
