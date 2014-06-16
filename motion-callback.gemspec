# -*- encoding: utf-8 -*-
VERSION = "0.1"

Gem::Specification.new do |spec|
  spec.name          = "motion-callback"
  spec.version       = VERSION
  spec.authors       = ["Steve Ross"]
  spec.email         = ["sxross@gmail.com"]
  spec.description   = %q{Allows for multi-branch callbacks from a single method. This allows for blocks of code
to be invoked in response to asynchronous events triggered in the called method.}
  spec.summary       = %q{Multi-branch callbacks}
  spec.homepage      = ""
  spec.license       = ""

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
end
