require 'rubygems'

Encoding.default_external = 'UTF-8'
Encoding.default_internal = 'UTF-8'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
