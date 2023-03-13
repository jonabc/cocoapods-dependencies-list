# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cocoapods_dependencies_list/version"

Gem::Specification.new do |spec|
  spec.name = "cocoapods-dependencies-list"
  spec.version = CocoapodsDependenciesList::VERSION
  spec.authors = ["Jon Ruskin"]
  spec.email = ["jon.ruskin@gmail.com"]

  spec.summary = "List dependencies from cocoapods in an easily parseable format."
  spec.homepage = "https://github.com/jonabc/cocoapods-dependencies-list"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/jonabc/cocoapods-dependencies-list"
  spec.metadata["changelog_uri"] = "https://github.com/jonabc/cocoapods-dependencies-list/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "debug"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop-github", "~> 0.20"
end
