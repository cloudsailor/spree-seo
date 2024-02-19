# frozen_string_literal: true

require_relative "lib/spree/seo/version"

Gem::Specification.new do |spec|
  spec.name = "spree-seo"
  spec.version = Spree::Seo::VERSION
  spec.authors = ["Jibran Usman"]
  spec.email = ["jibran.usman@hotmail.com"]

  spec.summary = "An SEO add-on for the Spree gem that adds on a layer of SEO functions"
  # spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "https://github.com/cloudsailor/spree-seo"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "http://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cloudsailor/spree-seo"
  spec.metadata["changelog_uri"] = "https://github.com/cloudsailor/spree-seo/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .travis appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
