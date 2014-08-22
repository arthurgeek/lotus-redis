# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lotus/redis/version"

Gem::Specification.new do |spec|
  spec.name          = "lotus-redis"
  spec.version       = Lotus::Redis::VERSION
  spec.authors       = ["Arthur Zapparoli"]
  spec.email         = ["arthurzap@gmail.com"]
  spec.summary       = spec.description = %q{redis adapter for Lotus::Model}
  spec.homepage      = "http://www.github.com/arthurgeek/lotus-redis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z -- lib/* CHANGELOG.md LICENSE.md README.md lotus-redis.gemspec`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "lotus-model", "~> 0.1"
  spec.add_dependency "redis", "~> 3.1"
end
