# frozen_string_literal: true
require_relative "lib/spree/seo/version"

Gem::Specification.new do |spec|
  spec.name = "spree-seo"
  spec.version = Spree::Seo::VERSION
  spec.authors = ["Jibran Usman"]
  spec.email = ["jibran.usman@hotmail.com"]

  spec.summary = "An SEO add-on for the Spree gem that adds on a layer of SEO functions"
  spec.homepage = "https://github.com/cloudsailor/spree-seo"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "http://rubygems.org/"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cloudsailor/spree-seo"
  spec.metadata["changelog_uri"] = "https://github.com/cloudsailor/spree-seo/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .travis appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'spree'
  spec.add_dependency 'spree_backend'
  spec.add_dependency 'spree_gateway'
  spec.add_dependency 'rails'
end
