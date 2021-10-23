# frozen_string_literal: true

require_relative "lib/alpha_vantage/version"

Gem::Specification.new do |spec|
  spec.name = "alpha_vantage"
  spec.version = AlphaVantage::VERSION
  spec.authors = ["Sergey Shkarupa"]
  spec.email = ["s.shkarupa@gmail.com"]

  spec.summary = "A gem for Alpha Vantage API"
  spec.description = "A ruby wrapper for Alpha Vantage API"
  spec.homepage = "https://github.com/sshkarupa/alpha_vantage"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # When gem is installed from source, we add `ruby-next` as a dependency
  # to auto-transpile source files during the first load
  if ENV["RELEASING_GEM"].nil? && File.directory?(File.join(__dir__, ".git"))
    spec.add_runtime_dependency "ruby-next", "~> 0.12.0"
  else
    spec.add_runtime_dependency "ruby-next-core", "~> 0.12.0"
  end

  spec.add_development_dependency "bundler", ">= 1.0.0"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "webmock", "~> 3.14"
  spec.add_development_dependency "rake", ">= 13.0.0"
  spec.add_development_dependency "ruby-next", "~> 0.12.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
