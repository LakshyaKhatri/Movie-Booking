# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "movie_booking/version"

Gem::Specification.new do |spec|
  spec.name        = "movie_booking"
  spec.version     = MovieBooking::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ["Lakshya Khatri"]
  spec.email       = ["lakshyak67@gmail.com"]
  spec.homepage    = "https://lakshya.codes"
  spec.summary     = "A terminal based movie booking system."
  spec.description = "Movie Booking :)"
  spec.license = "MIT"

  spec.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if spec.respond_to? :required_rubygems_version=

  spec.files         = Dir["lib/**/*"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 3.0.0"

  spec.add_dependency "tty-prompt", "~> 0.23.1"
  spec.add_dependency "tty-table", "~> 0.12.0"
  spec.add_dependency "titleize", "~> 1.4.1"

  spec.add_development_dependency "rubocop", "~> 1.62.1"
end
