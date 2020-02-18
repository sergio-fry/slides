Gem::Specification.new do |spec|
  spec.name = "rails-main"
  spec.version = "1.0.0"
  spec.author = "Roger Wilco"
  spec.summary = "Main rails-app"

  spec.add_dependency "rails", "~> 6.0.2"
  spec.add_dependency "sqlite3"
  spec.add_dependency "sass-rails", ">= 6"
  spec.add_dependency "webpacker", "~> 4.0"
  spec.add_dependency "bootsnap"

  spec.add_development_dependency "rspec-rails"
end
