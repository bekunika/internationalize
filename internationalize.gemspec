
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "internationalize/version"

Gem::Specification.new do |spec|
  spec.name          = "internationalize"
  spec.version       = Internationalize::VERSION
  spec.authors       = ["Beka Meshvildishvili"]
  spec.email         = ["meshvildishvili@gmail.com"]

  spec.summary       = "internationalize gem for ruby on rails"
  spec.description   = "internationalize gem for ruby on rails"
  spec.homepage      = "https://github.com/bekunika/simple_upload-rails"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.add_dependency 'activerecord', '>= 4.2', '< 5.2'
  spec.add_dependency 'activemodel', '>= 4.2', '< 5.2'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
