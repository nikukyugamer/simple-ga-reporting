lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "simple_ga_reporting/version"

Gem::Specification.new do |spec|
  spec.name          = "simple_ga_reporting"
  spec.version       = SimpleGaReporting::VERSION
  spec.authors       = ["Osamu Takiya"]
  spec.email         = ["takiya@toran.sakura.ne.jp"]

  spec.summary       = %q{With simple configuration (YAML), you can obtain Google Analytics reporting data}
  spec.description   = %q{This gem is powered by Legato gem. First of all, you create configuration YAML file as Google Analytics API. Then execute the simple Ruby code, and you obtain Google Analytics Reporting Data. Very simple.}
  spec.homepage      = "https://github.com/corselia/simple-ga-reporting"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency "legato"
  spec.add_development_dependency "oauth2"
  spec.add_development_dependency "signet"
end
