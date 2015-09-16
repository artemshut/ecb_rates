Gem::Specification.new do |spec|
  spec.name          = "ecb_rates"
  spec.version       = "0.0.1"
  spec.authors       = ["Artsiom Shut"]
  spec.email         = ["artemshut@gmail.com"]
  spec.description   = %q{ECB rates for UOL.}
  spec.summary       = %q{ECB rates for UOL.}
  spec.homepage      = "https://github.com/artemshut/ecb_rates"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rspec', '~> 0'
end
