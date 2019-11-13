
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rusty_symbol/version"

Gem::Specification.new do |spec|
  spec.name          = "rusty_symbol"
  spec.version       = RustySymbol::VERSION
  spec.authors       = ["atomiyama"]
  spec.email         = ["tomisuker16@gmail.com"]

  spec.summary       = "Symbol#start_with? and #end_with? methods implemented in Rust"
  spec.description   = "Symbol#start_with? and #end_with? methods implemented in Rust"
  spec.homepage      = "https://github.com/atomiyama/rusty_symbol"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions = ['ext/rusty_symbol/extconf.rb']

  spec.add_dependency "thermite"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "benchmark-ips"
end
