# frozen_string_literal: true

require_relative "lib/uddf/version"

Gem::Specification.new do |spec|
  spec.name          = "uddf"
  spec.version       = UDDF::VERSION
  spec.authors       = ["Flipez"]
  spec.email         = ["gh@flipez.net"]

  spec.summary       = "Ruby UDDF Parser and Writer"
  spec.description   = "A Ruby library for parsing and writing UDDF (Universal Data Description Format) files."
  spec.homepage      = "https://github.com/Flipez/ruby-uddf"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Flipez/ruby-uddf"
  spec.metadata["changelog_uri"] = "https://github.com/Flipez/ruby-uddf"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.18"
  spec.add_dependency "nokogiri-happymapper"

  spec.add_development_dependency "irb"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "rubocop", "~> 1.7"
  spec.add_development_dependency "rubocop-rake", "~> 0.7"
  spec.add_development_dependency "rubocop-rspec", "~> 3.6"
  spec.add_development_dependency "simplecov", "~> 0.21"
end
