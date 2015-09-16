Gem::Specification.new do |spec|
  spec.name          = "ecb_rates"
  spec.version       = "0.0.0"
  spec.authors       = ["Artsiom Shut"]
  spec.email         = ["artemshut@gmail.com"]
  spec.description   = %q{ECB rates for UOL.}
  spec.summary       = %q{ECB rates for UOL.}
  spec.homepage      = "https://github.com/artemshut/ecb_rates"
  spec.license       = "MIT"

  spec.files         = ["lib/ecb_rates.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

end
